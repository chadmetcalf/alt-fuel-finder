require 'rails_helper'

RSpec.describe User, type: :model do
  it "creates or updates itself from an oauth hash" do
    auth = {
      provider: "google",
      uid: "123",
      info: {
        email: "alishersadikov@mgail.com",
        first_name: "Alisher",
        last_name: "Sadikov"
      },
      credentials: {
        token: "abc123",
        refresh_token: "123abc",
        expires_at: DateTime.now
      }
    }
    User.update_or_create(auth)
    new_user = User.first

    expect(new_user.provider).to eq("google")
    expect(new_user.uid).to eq("123")
    expect(new_user.email).to eq("alishersadikov@gmail.com")
    expect(new_user.first_name).to eq("Alisher")
    expect(new_user.last_name).to eq("Sadikov")
    expect(new_user.token).to eq("abc123")
    expect(new_user.refresh_token).to eq("123abc")
    expect(new_user.oauth_expires_at).to eq(auth[:credentials][:expires_at])

  end
end
