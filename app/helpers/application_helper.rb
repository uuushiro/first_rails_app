module ApplicationHelper
  def current_user?(user)
    current_user.id == user.id
  end


  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end
end
