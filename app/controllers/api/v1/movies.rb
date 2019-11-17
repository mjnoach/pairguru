module API
  module V1
    class Movies < Grape::API
      include API::V1::Defaults

      resource :movies do
        desc "Return all movies"
        get "" do
          Movie.all
        end

        desc "Return a movie"
        params do
          requires :id, type: String, desc: "Movie id"
        end
        get ":id" do
          Movie.find(params[:id])
        end
      end
    end
  end
end
