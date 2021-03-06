class User < ApplicationRecord
  has_many :blogs
  has_many :favorites, dependent: :destroy
  before_validation { email.downcase! }
  validates :profile_picture, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, length: { minimum: 1 }
  mount_uploader :profile_picture, ImageUploader
end
