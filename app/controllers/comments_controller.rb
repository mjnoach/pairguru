class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    comment = current_user.comments.new(comment_params)
    comment.movie = Movie.find(params[:movie_id])
    if !comment.save
      flash[:comment_errors] = comment.errors.full_messages
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.permit(:body)
  end
end