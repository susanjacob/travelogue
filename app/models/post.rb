class Post < ActiveRecord::Base
  attr_accessible :title, :url, :user

  validates :title, :url, presence: true
  validates :title, uniqueness: true

  belongs_to :user
end
