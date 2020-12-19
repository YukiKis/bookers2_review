FactoryBot.define do
  factory :user do
    name { "yuki" }
    email { "yuki@com" }
    password { "testtest" }
  end
  
  factory :user2 do
    name { "nana" }
    email { "nana@com" }
    password { "testtest" }
  end
end