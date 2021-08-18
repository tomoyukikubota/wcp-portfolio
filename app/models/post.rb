class Post < ApplicationRecord

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy

  has_many_attached :images

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end


end
