require 'digest/md5'

class ApplicationController < ActionController::Base
  include AuthenticatingController

  before_action :set_gravatar

  private

  def set_gravatar
    if session[:email]
      hash = Digest::MD5.hexdigest(session[:email].downcase)
      @gravatar = "https://www.gravatar.com/avatar/#{hash}?d=https://www.herokucdn.com/images/ninja-avatar-96x96.png"
    else
      @gravatar = "https://www.herokucdn.com/images/ninja-avatar-96x96.png"
    end
  end

  #protect_from_forgery with: :exception
end
