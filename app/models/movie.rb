# == Schema Information
#
# Table name: movies
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  released_at :datetime
#  avatar      :string
#  genre_id    :integer
#  created_at  :datetime
#  updated_at  :datetime
#

class Movie < ApplicationRecord
  belongs_to :genre
  has_many :comments, dependent: :destroy
  validates_with TitleBracketsValidator
  attr_accessor :plot, :rating, :poster_url

  def fetch_api_data
    data = MovieFetcher.new.call(self[:title])
    @plot = data['plot']
    @rating = data['rating']
    @poster_url = data['poster']
    self
  end
end
