class Post < ApplicationRecord
  belongs_to :user

  validates :image, presence: true
  validates :title, presence: true, length: {maximum: 25}
end
