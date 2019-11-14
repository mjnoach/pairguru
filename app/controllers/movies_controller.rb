class MoviesController < ApplicationController
  before_action :authenticate_user!, only: [:send_info]
  after_action :clear_comment_errors, only: [:show]

  def index
    @movies = Movie.all.decorate
  end

  def show
    @movie = Movie.find(params[:id]).decorate(context: {current_user: current_user})
  end

  def send_info
    @movie = Movie.find(params[:id])
    MovieInfoMailer.send_info(current_user, @movie).deliver_now
    redirect_back(fallback_location: root_path, notice: "Email sent with movie info")
  end

  def export
    file_path = "tmp/movies.csv"
    MovieExporter.new.call(current_user, file_path)
    redirect_to root_path, notice: "Movies exported"
  end

  private

  def clear_comment_errors
    session.delete :comment_errors
  end
end
