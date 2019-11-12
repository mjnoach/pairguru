class MovieFetcher
  @@api_base = "https://pairguru-api.herokuapp.com"

  def call(movie_title)
    movie_url = @@api_base + "/api/v1/movies/" + URI.escape(movie_title)
    data = Rails.cache.fetch(movie_url) do
      HTTParty.get(movie_url).parsed_response['data']['attributes']
    end
    data = HTTParty.get(movie_url).parsed_response['data']['attributes']
    data['poster'] = @@api_base + data['poster']
    data
  end
end
