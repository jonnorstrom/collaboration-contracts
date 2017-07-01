class ContractsController < ApplicationController
  include ContractsHelper
  before_action :require_login

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    @contract = add_links(@contract)
    @contract.creator = current_user
    if @contract.save
      UserContract.create_owner_join(current_user, @contract)
      redirect_to @contract.path
    else
      @error_messages = @contract.errors.full_messages
      render 'contracts/new'
    end
  end

  def update
    @contract = Contract.find_by(id: params[:id], owner_link: params[:link])
    @contract.toggle_task(params[:task])
    @contract.save
    if params[:refresh] == "false"
      redirect_to root_path
    else
      redirect_to @contract.path
    end
  end

  def show
    @contract = Contract.find_which_by(params)
    @contract.set_user_contract(params[:link], current_user)
    @owner = @contract.owner?(current_user)
    @viewer = @contract.viewer?(current_user)
  end

  def destroy
    Contract.find(params[:contract_id]).destroy
    redirect_to root_path
  end

  def invite_users
    @contract = Contract.find(params[:id])
    render 'contracts/invite_users'
  end

  private
  def contract_params
    params.require(:contract).permit(:title, :theme, :creator_id)
  end

end
