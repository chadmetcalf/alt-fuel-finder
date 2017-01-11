require 'rails_helper'

describe "dashboard page" do
  it "lets the user to fetch fuel stations along route" do
    # allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit user_dashboard_path

    fill_in "start", with: "Denver, CO"
    fill_in "end", with: "Boston, MA"
    fill_in "interval", with: "200"
    find("#fuel-type").find("option[value='ELEC']").select_option
    click_button "submit"

    save_and_open_page
  end
end
