require "rails_helper"

describe API::V1::Movies do
  let!(:movies) { create_list(:movie, 10) }

  context 'GET /api/v1/movies' do
    before(:each) do 
      get '/api/v1/movies'
    end
    
    it 'returns an array of movies' do
      expect(response.status).to eq(200)
      expect(JSON.parse(response.body).count).to eq 10
    end

    it 'returns objects with id and title' do 
      expect(JSON.parse(response.body).sample).to include("id", "title")
    end
  end

  context 'GET /api/v1/movies/:id' do
    it 'returns a movie by id' do
      movie = movies.sample
      get "/api/v1/movies/#{movie.id}"
      resp = JSON.parse(response.body)
      expect(resp['id']).to eq movie.id
      expect(resp['title']).to eq movie.title
    end

    it 'returns relevant genre details along with the movie' do
      movie = movies.sample
      get "/api/v1/movies/#{movie.id}"
      resp = JSON.parse(response.body)
      expect(resp).to include("genre")
      expect(resp['genre']).to include("id", "name", "number_of_movies")
    end
  end
end