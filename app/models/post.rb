class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_attached_file :pics, styles: { large: "600x600>", medium: "400x400>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment :pics, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  validates_with AttachmentSizeValidator, attributes: :pics, less_than: 1.megabytes
end
