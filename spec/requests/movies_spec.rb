require "rails_helper"

describe "Movies requests", type: :request do
  let!(:movies) { create_list(:movie, 10) }

  describe "movies list" do
    it "displays right title" do
      visit "/movies"
      expect(page).to have_selector("h1", text: "Movies")
    end

    it "displays list of movies" do
      visit "/movies"
      expect(page).to have_selector("table tr", count: 10)
    end
  end

  describe "movie page" do
    before(:each) do
      allow_any_instance_of(Movie).to receive(:fetch_api_data).and_return(create(:movie))
    end

    it "displays rating" do
      allow_any_instance_of(Movie).to receive(:fetch_api_data).and_return( create(:movie) )
      visit "/movies/" + movies.sample.id.to_s
      expect(page).to have_selector("h3", text: "Rating:")
    end

    it "displays new comment form" do
      visit "/movies/" + movies.sample.id.to_s
      expect(page).to have_selector("form")
    end

    it "displays list of comments" do
      visit "/movies/" + movies.sample.id.to_s
      expect(page).to have_selector("ul")
    end
  end

  context "when logged in" do
    let!(:current_user) do |user|
      user = create(:user)
      user.confirm
      sign_in user
      user
    end

    describe "movie page" do
      it "displays an option to email movie details" do
        allow_any_instance_of(Movie).to receive(:fetch_api_data).and_return( create(:movie) )
        visit "/movies/" + movies.sample.id.to_s
        expect(page).to have_selector("p a", text: "Email me details about this movie")
      end
    end
  end
end