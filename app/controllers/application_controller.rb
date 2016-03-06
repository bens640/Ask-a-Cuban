class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_filter :mobile_login, :upvote_mobile, :downvote_mobile

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



  def upvote_mobile
    if params[:upvote]
        current_user.votes.build(vote_params).save
    end
  end

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

