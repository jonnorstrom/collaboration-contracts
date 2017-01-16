class ContractsController < ApplicationController
  include ContractsHelper

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    @contract = make_links(@contract)

    if user_signed_in?
      if @contract.save
        UserContract.create_owner_join(current_user, @contract)
        redirect_to "/contracts/#{@contract.id}/#{@contract.link}"
      else
        @error_messages = @contract.errors.full_messages
        render "home/index"
      end
    else
      render "users/sessions/new"
    end
  end

  def update
    @contract = Contract.find_by(id: params[:id], owner_link: params[:link])
    if params[:task] == "review"
      @contract.toggle_review
    elsif params[:task] == "complete"
      @contract.toggle_complete
    end
    @contract.save
    if params[:refresh] == "false"
      redirect_to root_path
    else
      redirect_to "/contracts/#{@contract.id}/#{@contract.link}"
    end
  end

  def show
    if !current_user
      render "users/registrations/new"
    else
      @contract = Contract.find_which_by(params)
      @contract.set_user_contract(params[:link], current_user)
      @owner = @contract.owner?(current_user)
    end
  end

  def destroy
    Contract.find(params[:contract_id]).destroy
    redirect_to root_path
  end

  private
  def contract_params
    params.require(:contract).permit(:title, :theme)
  end

end
