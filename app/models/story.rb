class Story < ActiveRecord::Base
  has_one :companies, dependent: :nullify
  self.primary_key = "sid"
end