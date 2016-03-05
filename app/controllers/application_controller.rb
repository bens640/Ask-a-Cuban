class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :mobile_login

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  def mobile_login
    if params[:username].present?
      u = User.find_or_create_by(username: params[:username])
      auto_login u
    end
  end
  end

