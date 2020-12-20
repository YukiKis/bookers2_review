class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  
  validates :title, presence:  true
  validates :opinion, presence: true
end
