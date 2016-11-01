class AnswersController < ApplicationController
  def new
    @decision_id = params[:decision_id]
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      @contract_link = Contract.find(Decision.find(@answer.decision_id).contract_id).link
      redirect_to "/contracts/#{@contract_link}"
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:name, :answer, :decision_id)
  end
end
