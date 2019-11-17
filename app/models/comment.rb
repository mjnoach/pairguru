class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validates :body, presence: true

  def self.top_commenters
    ranking = group(:user_id).order(Arel.sql('COUNT(id) DESC')).limit(10).count(:id)
    ranking.map do |user_id, comments_count|
      user_name = User.find(user_id).name
      [user_name, comments_count]
    end
  end
end
