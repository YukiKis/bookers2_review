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
  has_many :followers, dependent: :destroy, through: :passive_relationships, source: :follower
  has_many :followings, dependent: :destroy, through: :active_relationships, source: :followed
  
  def following?(user)
    self.active_relationships.where(followed_id: user.id).present?
  end
  
  def follow(user)
    self.active_relationships.create(followed_id: user.id)
  end
  
  def unfollow(user)
    self.active_relationships.find_by(followed_id: user.id).destroy
  end
end
