class Notification < ApplicationRecord

  #スコープ(新着順)
  default_scope -> { order(created_at: :desc) }

  # belongs_toのつけられたカラムには自動的にallow_nil: falseが付与される
  # フォロー通知ではpost_idは関与しないためnilとなるので、オプションをつけないとフォロー通知が有効にならない
  belongs_to :post, optional: true #optional: trueはpost_idにnilを許容するもの
  belongs_to :post_comment, optional: true
  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

end
