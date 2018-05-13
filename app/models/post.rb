class Post < ActiveRecord::Base
  attr_accessible :title, :url, :user

  # Title, URL, owner (user) are mandatory to save a post
  validates :title, :url, :user, presence: true
  # Post title cannot be repeated
  validates :title, uniqueness: true

  # Each post belongs to one registered user
  belongs_to :user
end
