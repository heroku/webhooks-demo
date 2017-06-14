require 'digest/md5'

class ApplicationController < ActionController::Base
  before_action :load_gravatar

  private

  def load_gravatar
    if session[:email]
      hash = Digest::MD5.hexdigest(session[:email].downcase)
      @gravatar = "https://www.gravatar.com/avatar/#{hash}?d=https://www.herokucdn.com/images/ninja-avatar-96x96.png"
    else
      @gravatar = "https://www.herokucdn.com/images/ninja-avatar-96x96.png"
    end
  end

  #protect_from_forgery with: :exception
end
