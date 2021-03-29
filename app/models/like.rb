class Like < ActiveRecord::Base
  belongs_to :user

  validates :user_id, presence: true

  def self.get_likelist(like)
    likedlist_str = like.likedlist
    list = likedlist_str.split(',')
    list
  end

end