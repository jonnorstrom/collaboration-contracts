class ContractsController < ApplicationController
  include ContractsHelper

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    @contract = make_links(@contract)

    if session[:user_id]
      @contract.user_id = session[:user_id]
    else
      @user = User.create
      @contract.user_id = @user.id
      session[:user_id] = @user.id
    end

    if @contract.save
      redirect_to "/contracts/#{@contract.id}/#{@contract.link}"
    end
  end

  def update
    @contract = Contract.find_by(id: params[:id], owner_link: params[:link])
    if params[:task] == "review"
      @contract.toggle(:reviewable)
    elsif params[:task] == "complete"
      @contract.toggle(:complete)
    end
    @contract.save
    redirect_to "/contracts/#{@contract.id}/#{@contract.link}"
  end

  def show
    @contract = Contract.find_which_by(params)
    @user = {id: session[:user_id], name: session[:name]}
    @owner = @contract.find_or_set_owner(params[:link], session[:user_id])
    session[:user_id] = @contract.user_id if @owner
  end

  private
  def contract_params
    params.require(:contract).permit(:title, :theme)
  end

end
