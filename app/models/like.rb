class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # 一人のユーザーはいいねを1回までとする
  validates_uniqueness_of :post_id, scope: :user_id
end
