class Company < ActiveRecord::Base
  has_many :products, dependent: :nullify
  has_many :stories, dependent: :nullify
  self.primary_key = "company_id"
  
  def self.company_to_user_by_distance(user_id)
    # Add the following to the user load:
    # geocoded_by :ip_address,
    # :latitude => :lat, :longitude => :lon
    # after_validation :geocode
    @companies = Company.all
    temp_user_address = '4200 Fifth Ave, Pittsburgh, PA 15260'
    user_addr=Geokit::Geocoders::GoogleGeocoder.geocode temp_user_address
    @distances = Hash.new
    @companies.each do |c|
      if c.address.nil? == false
        dist = user_addr.distance_to(c.address)
        @distances[c.company_id] = dist
      end
    end
    @distances
  end
end
