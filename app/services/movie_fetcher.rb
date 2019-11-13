class MovieFetcher
  @@api_base = "https://pairguru-api.herokuapp.com"

  def call(movie_title)
    movie_url = @@api_base + "/api/v1/movies/" + URI.escape(movie_title)
    data = HTTParty.get(movie_url).parsed_response['data']['attributes']
    puts data['poster']
    data['poster'] = @@api_base + data['poster']
    data
  end
end
