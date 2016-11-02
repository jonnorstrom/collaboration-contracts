class ContractsController < ApplicationController
  include ContractsHelper

  def new
    @contract = Contract.new
  end

  def create
    @contract = Contract.new(contract_params)
    @contract.link = make_link
    
    if @contract.save
      redirect_to "/contracts/#{@contract.link}"
    end
  end

  def show
    @contract = Contract.find_by(link: params[:id])
  end

  private
  def contract_params
    params.require(:contract).permit(:title)
  end

end
