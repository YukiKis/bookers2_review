FactoryBot.define do
  factory :comment do
    book_id { 1 }
    user_id { "" }
    content { "MyText" }
  end
end
