class User < ActiveRecord::Base
	has_many :posts
	has_many :comments
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :avatar, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 1.megabytes
  validates_presence_of :username, :email, :password
  validates_uniqueness_of :email
  validates_presence_of :password_confirmation, on: :create
  validates_confirmation_of :password
end