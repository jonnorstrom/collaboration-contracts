class HomeController < ApplicationController
  def index
    if current_user
      redirect_to user_dashboard_path
    end
  end
end
