class CommentCreator
  def initialize(user, movie_id, params)
    @user = user
    @movie_id = movie_id
    @params = params
  end

  def call
    unless comment_already_exists?
      comment = @user.comments.new(@params)
      comment.movie = Movie.find(@movie_id)
      comment.save
      comment
    else
      raise ActionController::BadRequest.new(), "User has commented on that movie already"
    end
  end

  private

  def comment_already_exists?
    @user.comments.where(movie_id: @movie_id).exists?
  end
end