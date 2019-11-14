class MovieFetcher
  API_BASE = "https://pairguru-api.herokuapp.com"

  def call(movie_title)
    movie_url = API_BASE + "/api/v1/movies/" + URI.escape(movie_title)
    data = HTTParty.get(movie_url).parsed_response['data']['attributes']
    data['poster'] = API_BASE + data['poster']
    data
  end
end
