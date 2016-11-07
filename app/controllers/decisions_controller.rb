class DecisionsController < ApplicationController

  def new
    @contract_id = params[:contract_id]
  end

  def create
    @decision = Decision.new(decision_params)
    if @decision.save
      @contract = Contract.find(@decision.contract_id)
      redirect_to "/contracts/#{@contract.link}"
    end
  end

  def show
    # @decision = Decision.find_by(link: params[:id])
    # @answers = Answer.where(decision_id: @decision.id)
  end


private
  def decision_params
    params.require(:decision).permit(:description, :contract_id)
  end
end
