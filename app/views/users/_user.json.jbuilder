json.extract! user, :id, :name, :username, :email, :password_digest, :uid, :token, :created_at, :updated_at
json.url user_url(user, format: :json)