require 'platform-api'

class SessionsController < ActionController::Base
  def new
    redirect_to "/auth/heroku"
  end

  def create
    # DO NOT store this token in an unencrypted cookie session
    # Please read "A note on security" below!
    # secret_key_base is set in secret.yml so this is encrypted
    session[:token] = request.env['omniauth.auth']['credentials']['token']
    session[:email] = request.env['omniauth.auth']['info']['email']

    redirect_to "/dashboard"
  end

  def logout
    session.clear
    redirect_to "https://dashboard.heroku.com/logout"
  end
end
