class User < ActiveRecord::Base
  self.primary_key = "id"
  has_one :cart, foreign_key: 'user_id', dependent: :nullify
  has_one :like, foreign_key: 'user_id', dependent: :nullify
  has_many :post, foreign_key: 'user_id', dependent: :nullify

  validates :fname, presence: true
  validates :lname, presence: true
  validates :username, presence: true
  validates :password, presence: true

  def self.register_email(email)
    client = Aws::SNS::Client.new(region: 'us-east-1',
      access_key_id: 'AKIAQ2KQVMG47K7DN476',
      secret_access_key: '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')
    sns = Aws::SNS::Resource.new(client: client)
    topic = sns.topic('arn:aws:sns:us-east-1:056540619193:svipd-stories')

    # Currently email id is hardcoded.
    sub = topic.subscribe({
      protocol: 'email',
      endpoint: email
    })
  end

  def self.send_email_to_users_new_story(desc, title)
    client = Aws::SNS::Client.new(region: 'us-east-1',
      access_key_id: 'AKIAQ2KQVMG47K7DN476',
      secret_access_key: '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')
    sns = Aws::SNS::Resource.new(client: client)
    topic = sns.topic('arn:aws:sns:us-east-1:056540619193:svipd-stories')
    topic.publish(  { message: desc,
                      subject: title
                    } )

  end

  def self.get_applicable_stores(barcodes, radius, loc)
    # barcodes is an array of strings
    # radius is a float
    # loc = request.location.address but can only do request in controller
    # example usage: 'User.get_applicable_stores(["043765009345", 
    #                 "194721725820"], 10000,session[:location])'
    barcodes = barcodes.sort

    # First, get all products that has an applicable barcode ID
    products = Product.all.where('barcode in (?)', barcodes)

    # Next, get distance for all applicable products
    products = Product.gen_dist_and_order(products, loc, "dist", true)

    # Make a hash that maps company_id to barcodes to determine
    # eligibility
    # Make a hash that maps company_id to relevant info like
    # (company address, name, total price, distance)
    comp_to_barcodes = Hash.new
    comp_info = Hash.new
    products.each do |p|
      if p.distance <= radius # enforce radius
        if comp_to_barcodes.key? (p.company_id) == false \
           or comp_to_barcodes[p.company_id].nil?
          comp_to_barcodes[p.company_id] = Array.new
        end
        comp_to_barcodes[p.company_id].append(p.barcode)

        if comp_info.key? (p.company_id) == false \
           or comp_info[p.company_id].nil?
          new_hash = Hash.new
          new_hash["name"] = p.company.name
          new_hash["address"] = p.company.address
          new_hash["image_url"] = p.company.image_url
          new_hash["distance"] = p.distance
          new_hash["total"] = p.price
          new_hash["company_id"] = p.company_id
          comp_info[p.company_id] = new_hash
        else
          comp_info[p.company_id]["total"] += p.price
        end
      end
    end

    # Go through comp_to_barcodes and remove companies that do not
    # have all the products needed
    comp_to_barcodes.each do |k,v|
      v = v.sort
      if v != barcodes
        comp_to_barcodes.delete(k)
      end
    end

    # Remove any company that is no longer in comp_to_barcodes
    # (unnecessary, but to be sure) or if distance is out of range
    comp_info.each do |k, v|
      if comp_to_barcodes.key? (k) == false \
         or comp_to_barcodes[k].nil? or v["distance"] > radius 
        comp_info.delete(k)
      end
    end

    # Make a list of companies with (name, address, distance, total)
    companies = Array.new
    comp_info.each do |k, v|
      companies.append(v)
    end

    companies = companies.sort_by { |h| h["total"] }

    return companies
  end
end