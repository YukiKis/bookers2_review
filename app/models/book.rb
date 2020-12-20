class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :books, dependent: :destroy
  
  validates :title, presence:  true
  validates :opinion, presence: true
end
