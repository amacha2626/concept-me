class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  validates :image, presence: true
  validates :title, presence: true, length: {maximum: 25}
end
