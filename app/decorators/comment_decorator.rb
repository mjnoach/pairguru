class CommentDecorator < Draper::Decorator
  delegate_all

  def user_name
    User.find(object.user_id).name
  end
end
