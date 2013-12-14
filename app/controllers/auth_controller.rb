class AuthController < ApplicationController
  def callback
    auth_hash     = request.env['omniauth.auth']
    identity_info = auth_hash.slice('provider', 'uid').symbolize_keys
    user_info     = auth_hash['info'].slice('name', 'email').symbolize_keys

    identity = Identity.find_by(identity_info)

    if identity.nil?
      identity = Identity.create!(identity_info)
    end

    user = identity.user

    if user.nil?
      user = User.find_by(:email => user_info[:email])
    end

    if user.nil?
      user = User.create!(user_info)
      alert("Thanks for joining, #{user.name}!", :success)
    else
      alert("Welcome back, #{user.name}!")
    end

    if identity.user.nil?
      identity.user = user
      identity.save!
    end

    login_user(user)
    redirect_to(root_path)
  end
end
