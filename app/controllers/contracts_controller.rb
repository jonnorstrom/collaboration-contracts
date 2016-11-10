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
      p @user, "++++++++++"
      @contract.user_id = @user.id
      session[:user_id] = @user.id
    end

    if @contract.save
      redirect_to "/contracts/#{@contract.id}/#{@contract.link}"
    end
  end

  def show
    @contract = Contract.find_by(id: params[:id], link: params[:link]) || Contract.find_by(id: params[:id], owner_link: params[:link])

    if @contract.owner_link == params[:link]
      @is_owner = true
    else
      @is_owner = @contract.owner?(session[:user_id])
    end
  end

  private
  def contract_params
    params.require(:contract).permit(:title)
  end

end
