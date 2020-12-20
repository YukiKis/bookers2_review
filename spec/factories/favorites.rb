FactoryBot.define do
  factory :favorite, class: Favorite do
    user_id { 1 }
    book_id { 1 }
  end
end
