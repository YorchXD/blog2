class Post < ApplicationRecord
  belongs_to :blog
  belongs_to :user
  has_many :messages

  validates :title, presence: true, length: { minimum: 7}
  validates :content, presence: true
end
