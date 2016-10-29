class AnswersController < ApplicationController
  def new
    @contract_id = params[:contract_id]
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      @contract_link = Contract.find(@answer.contract_id).link
      redirect_to "/contracts/#{@contract_link}"
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:name, :answer, :contract_id)
  end
end
