class UsersController < ApplicationController

  def dashboard
    if !current_user
      render "users/registrations/new"
    else
      @owner_contracts = UserContract.owner_contracts(current_user)
      @contracts = UserContract.users_contracts(current_user)
    end
  end

end
