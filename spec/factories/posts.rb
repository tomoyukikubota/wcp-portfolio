FactoryBot.define do

  factory :post do
    title { "test" }
    body { "tester" }
    images { [ Rack::Test::UploadedFile.new(Rails.root.join( 'app/assets/images/bike1.jpg'), 'app/assets/images/bike2.jpg')  ] }
    user_id {"1"}
    association :user #@postモデルは@userが投稿するので、関連付けを定義する。
  end
  factory :post_no_image, class: Post do
    title { "test" }
    body { "tester" }
    # images { [ Rack::Test::UploadedFile.new(Rails.root.join( 'app/assets/images/bike1.jpg'), 'app/assets/images/bike2.jpg')  ] }
    user_id {"1"}
    association :user #@postモデルは@userが投稿するので、関連付けを定義する。
  end
end