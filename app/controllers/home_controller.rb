class HomeController < ApplicationController
  before_action :require_login

  def index
      redirect_to user_dashboard_path
  end

end
