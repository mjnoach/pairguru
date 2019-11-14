require "rails_helper"

describe "Comments requests", type: :request do

  describe "top commenters" do

    describe "movies without comments" do
      let!(:movies) { create_list(:movie, 10) }

      it "top commenters table is empty" do
        visit "/top_commenters"
        expect(page).to have_selector("table")
        expect(page).not_to have_selector("tbody tr")
      end
    end

    describe "movies with comments" do
      let!(:movies) { create_list(:movie, 10, :with_comments) }
      let!(:current_user) do |user|
        user = create(:user)
        user.confirm
        sign_in user
        user
      end

      it "displays top 10 commenters" do
        visit "/top_commenters"
        expect(page).to have_selector("tbody tr", count: 10)
      end

      it "displays user with most comments at the top" do
        movies.each do |movie|
          body = Faker::Lorem.sentence
          post movie_comments_path(movie.id, body: body)
        end

        visit "/top_commenters"
        expect(page).to have_selector("tbody tr", text: "1 #{current_user.name}")
      end
    end
  end

  context "when logged in" do
    let!(:movies) { create_list(:movie, 10) }
    let!(:current_user) do |user|
      user = create(:user)
      user.confirm
      sign_in user
      user
    end

    describe "valid comment" do
      let(:movie) { movies.sample }
      let(:body) { Faker::Lorem.sentence(1, true)}

      before(:each) do
        post movie_comments_path(movie.id, body: body)
      end

      it "can be added" do
        expect(response).to have_http_status(302)
      end

      it "can't be added more than once" do
        expect { post movie_comments_path(movie.id, body: body) }.to raise_error(ActionController::BadRequest)
      end

      context "can be deleted" do
        before(:each) do 
          comment = Comment.find_by(user_id: current_user, movie_id: movie.id)
          delete movie_comment_path(movie.id, comment.id)
        end

        it "successfully" do
          expect(response).to have_http_status(302)
        end

        it "and added again" do
          post movie_comments_path(movie.id, body: body)
          expect(response).to have_http_status(302)
        end
      end
    end

    describe "invalid comment" do
      it "passes an error when comment is not valid" do
        post movie_comments_path(movies.sample.id, body: "")
        expect(flash[:comment_errors]).not_to be_empty
      end
    end
  end
end