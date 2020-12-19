FactoryBot.define do
  factory :user, class: User do
    name { "yuki" }
    email { "yuki@com" }
    password { "testtest" }
  end
  
  factory :user2, class: User do
    name { "nana" }
    email { "nana@com" }
    password { "testtest" }
  end
end