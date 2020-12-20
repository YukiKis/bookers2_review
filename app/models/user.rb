class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy
  
  validates :name, length: { in: 2..20 }
  validates :email, presence: true
  
  attachment :image
  
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
end
