class SessionsController < ApplicationController
  def create
    user = User.update_or_create(env["omniauth.auth"])
    session[:id] = user.id
    redirect_to user_dashboard_path(current_user)
  end

  def destroy
    session.clear
    redirect_to root_path
  end
end
