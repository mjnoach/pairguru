require "rails_helper"

describe "Movies requests", type: :request do
  let!(:movies) { create_list(:movie, 10) }

  describe "movie page" do
    before(:each) do
      allow_any_instance_of(Movie).to receive(:fetch_api_data).and_return(create(:movie))
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
end