class Cart < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true

  def self.get_wishlist(cart)
    wishlist_str = cart.wishlist
    list = wishlist_str.split(',')
    list
  end

  def self.set_wishlist(cart, products)
    str = products.join(",")
    cart.wishlist = str
    cart
  end
end