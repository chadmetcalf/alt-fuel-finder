require 'rails_helper'

RSpec.feature "user logs in" do
  scenario "using google oauth2" do
    stub_omniauth

    visit root_path

    expect(page).to have_link("Sign in with Google")

    click_link "Sign in with Google"

    User.update_or_create(auth)
    new_user = User.firstx

    expect(new_user.provider).to eq("google")
    expect(new_user.uid).to eq("12345678910")
    expect(new_user.email).to eq("jesse@mountainmantechnologies.com")
    expect(new_user.first_name).to eq("Jesse")
    expect(new_user.last_name).to eq("Spevack")
    expect(new_user.token).to eq("abcdefg12345")
    expect(new_user.refresh_token).to eq("12345abcdefg")
    expect(new_user.oauth_expires_at).to eq(auth[:credentials][:expires_at])
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      provider: "google",
      uid: "12345678910",
      info: {
        email: "alishersadikov@mgail.com",
        first_name: "Alisher",
        last_name: "Sadikov"
      },
      credentials: {
        token: "abcdefg12345",
        refresh_token: "12345abcdefg",
        expires_at: DateTime.now,
      }
    })
  end
end
