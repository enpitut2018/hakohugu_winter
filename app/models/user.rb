class User < ApplicationRecord
    before_save { self.email = email.downcase }
    validates :name, presence: true, length: { maximum: 50 }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }
    validates :bio, length: { maximum: 500 }
    validates :link1, length: { maximum: 255 }
    validates :link2, length: { maximum: 255 }
    validates :link3, length: { maximum: 255 }
    has_many :documents
    has_many :templates
    has_many :likes, dependent: :destroy
    has_secure_password
    mount_uploader :picture, PictureUploader
end
