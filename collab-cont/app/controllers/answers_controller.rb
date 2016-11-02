class AnswersController < ApplicationController
  def new
    @decision_id = params[:decision_id]
    @answer = Answer.new()
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to "/contracts/#{@answer.contract_link}"
    end
  end

  private
  def answer_params
    params.require(:answer).permit(:name, :answer, :decision_id)
  end
end
