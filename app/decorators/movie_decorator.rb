class MovieDecorator < Draper::Decorator
  delegate_all

  def cover
    "http://lorempixel.com/100/150/" +
      %w[abstract nightlife transport].sample +
      "?a=" + SecureRandom.uuid
  end

  def current_user_comment
    @current_user_comment ||= comments.find_by_user_id(context[:current_user].id)
    @current_user_comment
  end

  def other_comments
    comments - [current_user_comment]
  end

  def comments
    @comments ||= object.comments
    @comments
  end
end
