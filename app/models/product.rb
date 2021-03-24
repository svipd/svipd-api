class Product < ActiveRecord::Base
  belongs_to :company
  self.primary_key = "pid"
  validates :company_id, presence: true
  validates :description, presence: true
  validates :name, presence: true
  validates :price, presence: true

  
  def self.get_all_distances(products)
    comp_dist = Company.company_to_current_user_by_distance()
    prod_to_dist = Hash.new
    products.each do |p|
      if comp_dist[p.company.company_id].nil? == false
        prod_to_dist[p.pid] = comp_dist[p.company.company_id].round(2)
      end
    end
    prod_to_dist
  end
end
