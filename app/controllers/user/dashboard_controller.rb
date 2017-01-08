class User::DashboardController < ApplicationController
  def show
    @user = User.find(params[:id])
    # @places = @user.
  end

  def fuel_stations
    @user = User.find(params[:id])

    NrelService.new.find_fuel_stations(@user)
    redirect_to user_dashboard_path(@user)
  end
end
