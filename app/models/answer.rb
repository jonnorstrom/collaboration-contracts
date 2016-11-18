class Answer < ApplicationRecord
  validates :name, presence: true
  validates :answer, presence: true
  validates :decision_id, presence: true

  belongs_to :decision

  def self.find_all_names(type, decision_id, user_id, user_name)
    names = Decision.find(decision_id).answers.where(answer: type).map do |answer|
      if answer.viewable?(user_id, user_name)
        return answer.name
      end
    end
    return names.join(", ")
  end

  def contract
    Contract.find(self.decision.contract_id)
  end

  def decision
    Decision.find(self.decision_id)
  end

  def viewable?(user_id, user_name)
    self.name == user_name || self.contract.owner?(user_id)
  end

end
