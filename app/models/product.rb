class Product < ActiveRecord::Base
  attr_accessor :distance
  belongs_to :company
  self.primary_key = "pid"
  validates :company_id, presence: true
  validates :description, presence: true
  validates :name, presence: true
  validates :price, presence: true

  def self.search_by_companyid(products, cid, search)
    searched_products = products.where("company_id = ?", cid)
    searched_products = self.case_insensitive_search(searched_products, search)
    searched_products
  end

  def self.case_insensitive_search(products, search)
    if search.nil?
      return products
    end

    searched_products = products.where("LOWER (name) LIKE ?  OR LOWER( description ) LIKE ? ", "%#{search.downcase}%", "%#{search.downcase}%")
    searched_products
  end

  def self.search(products, search)
    searched_products = products.where("name LIKE ?  OR  description LIKE ? ", "%#{search}%", "%#{search}%")
    searched_products
  end

  def self.gen_dist_and_order(products, loc, type, asc)
    if type == "price"
      products = Product.order_by_price(products, asc) #sort by asc price -> must go before generate dist
    end
    Product.generate_distances(products, loc)
    if type == "dist"
      products = Product.order_by_dist(products, asc) #sort by asc dist -> must go after generate dist
    end
    if type.include? "dist" and type.include? "price"
      products = Product.order_by_price_dist(products, asc)
    end

    products
  end

  def self.order_by_price_dist(products, asc)
    if asc == true
      searched_products = products.sort_by {|x| [x.distance, x.price]}
    else
      searched_products = products.sort_by {|x| [x.distance, x.price]}
      searched_products = searched_products.reverse
    end
    searched_products
  end

  def self.order_by_price(products, asc)
    if asc == true
      searched_products = products.order(price: :asc)
    else
      searched_products = products.order(price: :desc)
    end
    searched_products
  end

  def self.order_by_name(products, asc)
    if asc == true
      searched_products = products.order(name: :asc)
    else
      searched_products = products.order(name: :desc)
    end
    searched_products
  end

  def self.order_by_dist(products, asc)
    # NOTE: must run generate distances first!
    if asc == true
      searched_products = products.sort_by(&:distance)
    else
      searched_products = products.sort_by(&:distance).reverse
    end
    searched_products
  end

  def self.generate_distances(products, loc)
    comp_dist = Hash.new
    begin
    comp_dist = Company.company_to_current_user_by_distance(loc)
    rescue
      comp_dist = Hash.new
    end
    products.each do |p|
      if comp_dist[p.company.company_id].nil? == false
        p.distance = comp_dist[p.company.company_id].round(2)
      else
        p.distance = 10000000000
      end
    end
    products
  end
end