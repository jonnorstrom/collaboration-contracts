class AnswersController < ApplicationController
  def new
    @decision = Decision.find(params[:decision_id])
    @answer = Answer.new()
  end

  def create
    @answer = Answer.where(name: answer_params[:name], decision_id: answer_params[:decision_id]).first rescue nil
    if @answer.blank?
      @answer = Answer.new(answer_params)
    else
      @answer.update(answer_params)
    end

    if @answer.save
      session[:name] = @answer.name
      @contract_id = @answer.decision.contract_id
      redirect_to "/contracts/#{@contract_id}/#{@answer.contract.link}"
    end
  end


  private
  def answer_params
    params.require(:answer).permit(:name, :answer, :decision_id)
  end
end
