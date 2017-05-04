class AnswersController < ApplicationController
  def new
    @decision = Decision.find(params[:decision_id])
    @answer = Answer.new()
  end

  def create
    @answer = Answer.where(user_id: answer_params[:user_id], decision_id: answer_params[:decision_id]).first rescue nil
    if @answer.blank?
      @answer = Answer.new(answer_params)
    else
      @answer.update(answer_params)
    end

    if @answer.save
      redirect_to @answer.contract.path
    else
      @decision = @answer.decision
      render new_answers_path(@answer)
    end
  end


  private
  def answer_params
    params.require(:answer).permit(:user_id, :answer, :decision_id)
  end
end
