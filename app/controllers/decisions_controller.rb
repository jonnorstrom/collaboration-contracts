class DecisionsController < ApplicationController

  def new
    @decision = Decision.new
    @contract_id = params[:contract_id]
  end

  def create
    @decision = Decision.new(decision_params)
    @contract = Contract.find(@decision.contract_id)
    if @decision.save
      redirect_to "/contracts/#{@contract.id}/#{@contract.link}"
    else
      @decision_error_messages = @decision.errors.full_messages
      render "contracts/show"
    end
  end

  def update
    @decision = Decision.find(decision_params[:id])
    @contract = Contract.find(@decision.contract_id)
    if @decision.update(:description => decision_params[:description])
      redirect_to "/contracts/#{@contract.id}/#{@contract.link}"
    end
  end

  def destroy
    @decision = Decision.find(params[:decision_id])
    @contract = @decision.contract
    @decision.destroy
    redirect_to "/contracts/#{@contract.id}/#{@contract.link}"
  end


private
  def decision_params
    params.require(:decision).permit(:description, :contract_id, :id)
  end
end
