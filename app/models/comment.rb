class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :body, presence: true

  # scope :by_number_of_comments, -> {
  #   group: "user_id",
  #   order: "COUNT(id) DESC"
  # }
end
