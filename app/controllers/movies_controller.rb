class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]

  def index
    @movies = Movie.all
  end

  def show
    @movie = Movie.find(params[:id]).fetch_api_data
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_later
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    # MovieExporter.new.call(current_user, file_path)
    MoviesExportJob.perform_later(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end

  def api_data
    @movie = Movie.find(params[:id]).fetch_api_data
    render partial: params[:partial_view], locals: params[:locals]
  end
end
