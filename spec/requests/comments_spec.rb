require "rails_helper"

describe "Comments requests", type: :request do
  let!(:movies) { create_list(:movie, 10, :with_comments) }

  context "when logged in" do
    let!(:current_user) do |user|
      user = create(:user)
      user.confirm
      sign_in user
      user
    end

    describe "valid comment" do
      let(:movie) { movies.sample }

      before(:each) do
        body = Faker::Lorem.sentence(1, true)
        post movie_comments_path(movie.id, body: body)
      end

      it "can be added" do
        expect(response).to have_http_status(302)
      end

      it "can't be added more than once" do
        expect { post movie_comments_path(movie.id, body: body) }.to raise_error(ActionController::BadRequest)
      end

      it "can be deleted" do
        comment = Comment.find_by(user_id: current_user, movie_id: movie.id)
        delete movie_comment_path(movie.id, comment.id)
        expect(response).to have_http_status(302)
      end
    end

    describe "invalid comment" do
      it "passes an error when comment is not valid" do
        post movie_comments_path(movies.sample.id, body: "")
        expect(response).to have_http_status(:bad_request)
        expect(flash[:comment_errors]).not_to be_empty
      end
    end
  end
end