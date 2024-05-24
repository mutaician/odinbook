class Post < ApplicationRecord
  belongs_to :user
  validates :content, presence: true

  has_many :likes, dependent: :destroy
  has_many :likers, through: :likes, source: :user

  has_many :comments, dependent: :destroy
  has_many :commenters, through: :comments, source: :user
end
