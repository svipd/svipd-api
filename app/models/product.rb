class Product < ActiveRecord::Base
  belongs_to :company
  self.primary_key = "pid"
  
end
