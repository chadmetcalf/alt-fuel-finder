class User::DashboardController < ApplicationController
  def show
    @user = User.find(params[:id])
    # @places = @user.
  end
end
