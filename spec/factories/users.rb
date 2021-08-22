FactoryBot.define do

  factory :user do
    name {"広島太郎"}
    email {"test@gmail.com"}
    password {"111111"}
    encrypted_password {"111111"}
  end
end
