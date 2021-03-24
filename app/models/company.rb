class Company < ActiveRecord::Base
  self.primary_key = "company_id"
  has_many :products, dependent: :nullify
  has_many :stories, dependent: :nullify
  validates :name, presence: true
  validates :description, presence: true
  
  def self.company_to_current_user_by_distance(loc)
    # Add the following to the user load:
    # geocoded_by :ip_address,
    # :latitude => :lat, :longitude => :lon
    # after_validation :geocode
    @companies = Company.all
    user_addr = '4200 Fifth Ave, Pittsburgh, PA 15260'
    if loc.nil? == false
      user_addr = loc
    end
    user_addr=Geokit::Geocoders::GoogleGeocoder.geocode user_addr
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
