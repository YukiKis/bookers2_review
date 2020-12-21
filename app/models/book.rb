class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  
  validates :title, presence:  true
  validates :opinion, presence: true
  
  scope :search_forward, ->(keyword){ where("title LIKE ?", "#{ keyword }%") }
  scope :search_back, ->(keyword){ where("title LIKE ?", "%#{ keyword }") }
  scope :search_all, ->(keyword){ where("title LIKE ?", "%#{ keyword }%") }
end
