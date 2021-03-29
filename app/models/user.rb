class User < ActiveRecord::Base
  validates :fname, presence: true
  validates :lname, presence: true
  validates :username, presence: true
  validates :password, presence: true
end