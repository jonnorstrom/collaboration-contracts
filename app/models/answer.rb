class Answer < ApplicationRecord
  validates :name, presence: true
  validates :answer, presence: true
  validates :decision_id, presence: true

  belongs_to :decision

  def self.find_all_names(type, decision_id)
    names = Decision.find(decision_id).answers.where(answer: type).map { |a| a.name }
    return names.join(", ")
  end

  def contract_link
    Contract.find(self.decision.contract_id).link
  end

  def decision
    Decision.find(self.decision_id)
  end
end
