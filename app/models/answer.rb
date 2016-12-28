class Answer < ApplicationRecord
  validates :user_id, presence: true
  validates :answer, presence: true
  validates :decision_id, presence: true

  belongs_to :decision
  belongs_to :user

  def self.find_all_names(type, answers, user)
    names = answers.where(answer: type).select {|a| a.viewable?(user)}.map {|a| a.user.users_name}
    names.join(", ")
  end

  def self.types
    types = ['Explain', 'Consult', 'Agree', 'Advise', 'Inquire']
  end

  def contract
    Contract.find(self.decision.contract_id)
  end

  def viewable?(user)
    self.contract.reviewable || user_answer?(user) || self.contract_owner?(user)
  end


  def user_answer?(user)
    self.user == user
  end

  def contract_owner?(user)
    self.contract.owner?(user)
  end

end
