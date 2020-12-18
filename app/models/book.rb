class Book < ApplicationRecord
  belongs_to :user
  
  validates :title, null: false
  validates :opinion, null: false
end
