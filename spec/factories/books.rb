FactoryBot.define do
  factory :book, class: Book do
    title { "Hello" }
    opinion { "World" }
  end
end