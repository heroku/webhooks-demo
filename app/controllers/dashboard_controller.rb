class DashboardController < ApplicationController
  before_action :authenticate_user_action!

  def index

  end
end
