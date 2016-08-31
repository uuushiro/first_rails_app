class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  include ApplicationHelper

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
  end

  # ユーザーのログインを確認
  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end
end
