require 'platform-api'

class SessionsController < ApplicationController
  def new
    if ENV['HEROKU_OAUTH_ID'] && ENV['HEROKU_OAUTH_SECRET']
      redirect_to "/auth/heroku"
    else
      @app = heroku_app
      @oauth_name = request.host
      @oauth_url = request.base_url + "/auth/heroku/callback"
    end
  end

  def create
    # DO NOT store this token in an unencrypted cookie session
    # Please read "A note on security" below!
    # secret_key_base is set in secret.yml so this is encrypted
    session[:token] = request.env['omniauth.auth']['credentials']['token']
    session[:email] = request.env['omniauth.auth']['info']['email']
    session[:name] = request.env['omniauth.auth']['info']['name']

    redirect_to root_path
  end

  def logout
    session.clear
    redirect_to "https://dashboard.heroku.com/logout"
  end
end
