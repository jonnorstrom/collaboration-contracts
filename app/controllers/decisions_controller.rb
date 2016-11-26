class DecisionsController < ApplicationController

  def new
    @decision = Decision.new
    @contract_id = params[:contract_id]
  end

  def create
    @decision = Decision.new(decision_params)
    if @decision.save
      @contract = Contract.find(@decision.contract_id)
      redirect_to "/contracts/#{@contract.id}/#{@contract.link}"
    end
  end


private
  def decision_params
    params.require(:decision).permit(:description, :contract_id)
  end
end
