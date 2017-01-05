class User::DashboardController < ApplicationController
  def show
    @user = User.find(params[:id])
    # @places = @user.
  end

  def fuel_stations
    binding.pry
    NrelService.new.find_fuel_stations(@user)
    redirect_to user_dashboard_path(@user)
  end
end
