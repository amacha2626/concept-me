class Post < ApplicationRecord


  validates :image, presence: true
  validates :title, presence: true, length: {maximum: 25}
end
