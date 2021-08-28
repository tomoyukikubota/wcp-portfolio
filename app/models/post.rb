class Post < ApplicationRecord

  validates :title, presence: true
  validates :body, presence: true
  validates :images, presence: true

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  has_many_attached :images

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索(いいねを連続でした場合でも、1度しか相手に通知がいかないようにする)
    temp = Notification.where(["visiter_id = ? and visited_id = ? and post_id = ? and action = ? ", current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        post_id: id,
        visited_id: user_id,
        action: 'like'
      )

      unless notification.visiter_id == notification.visited_id
      notification.save if notification.valid?
      end
    end
  end


  def create_notification_comment!(current_user, post_comment_id)
    user_ids = PostComment.where.not(user_id: current_user.id).pluck(:post_id).uniq
    save_notification_comment!(current_user, post_comment_id, user_id{@post})
  end



  def save_notification_comment!(current_user, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      post_id: id,
      post_comment_id: post_comment_id,
      visited_id: visited_id,
      action: 'comment'
    )

    unless notification.visiter_id == notification.visited_id
      notification.save if notification.valid?
    end
  end


end







