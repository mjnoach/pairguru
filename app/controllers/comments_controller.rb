class CommentsController < ApplicationController
  before_action :authenticate_user!, except: [:top_commenters]

  def create
    comment = CommentCreator.new(current_user, params[:movie_id], comment_params).call
    if comment.persisted?
      redirect_back(fallback_location: root_path)
    else
      flash[:comment_errors] = comment.errors.full_messages
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_back(fallback_location: root_path)
  end

  def top_commenters
    @top_commenters = Comment.top_commenters
  end
  
  private

  def comment_params
    params.permit(:body)
  end
end