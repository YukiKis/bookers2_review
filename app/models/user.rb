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
  has_many :active_relationships, dependent: :destroy, class_name: :Relationship, foreign_key: :follower_id
  has_many :passive_relationships, dependent: :destroy, class_name: :Relationship, foreign_key: :followed_id
  has_many :followers, dependent: :destroy, source: :follower_id, through: :passive_relationships
  has_many :followings, dependent: :destroy, source: :followed_id, through: :active_relationships
  
  def following?(user)
    self.active_relationships.where(followed_id: user.id).present?
  end
end
