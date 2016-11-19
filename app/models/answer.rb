class Answer < ApplicationRecord
  validates :name, presence: true
  validates :answer, presence: true
  validates :decision_id, presence: true

  belongs_to :decision

  def self.find_all_names(type, answers, user)
    names = answers.where(answer: type).select {|a| a.viewable?(user)}.map {|a| a.name}
    names.join(", ")
  end

  def self.types
    types = ['Explain', 'Consult', 'Agree', 'Advise', 'Inquire']
  end

  def contract
    Contract.find(self.decision.contract_id)
  end

  def viewable?(user)
    self.contract.reviewable || self.name == user[:name] || self.contract.owner?(user[:id])
  end

end
