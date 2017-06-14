class DashboardController < ApplicationController
  include AuthenticatingController
  
  before_action :authenticate_user_action!

  def index

  end
end
