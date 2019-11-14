class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :body, presence: true, length: { minimum: 3 }
end
