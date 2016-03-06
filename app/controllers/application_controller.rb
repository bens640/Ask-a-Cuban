class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :mobile_login, :upvote_mobile, :downvote_mobile

  private
  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end

  # Lets mobile app use params to pass in username
  def mobile_login
    if params[:username].present?
      u = User.find_or_create_by(username: params[:username])
      auto_login u

    end
  end

  # Used by API to upvote an article by adding upvote=true to URL
  def upvote_mobile
    if params[:upvote]
        current_user.votes.build(vote_params).save
    end
  end
  # Used by API to downvote an article by adding downvote=true to URL
  def downvote_mobile
    if params[:downvote]
       Vote.where(user_id:current_user.id).where(votable_id:params[:id]).destroy_all
    end
  end
  def vote_params
      {
          votable_id: params[:id],
          votable_type: "Item"
      }
  end
  end

