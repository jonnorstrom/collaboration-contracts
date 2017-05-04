class DecisionsController < ApplicationController
  before_action :find_decision, only: [:edit, :destroy]

  def new
    @decision = Decision.new(:contract_id => session[:contract_id])
  end

  def create
    @decision = Decision.new(decision_params)
    @contract = @decision.contract
    if @decision.save
      redirect_to @contract.path
    else
      render decisions_new_path(@decision)
    end
  end

  def edit
  end

  def update
    @decision = Decision.find(decision_params[:id])
    @contract = @decision.contract
    if @decision.update(:description => decision_params[:description])
      redirect_to @contract.path
    end
  end

  def destroy
    @contract = @decision.contract
    @decision.destroy
    redirect_to @contract.path
  end


private
  def find_decision
    @decision = Decision.find(params[:decision_id])
  end

  def decision_params
    params.require(:decision).permit(:description, :contract_id, :id)
  end
end
