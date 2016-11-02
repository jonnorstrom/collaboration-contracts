class Answer < ApplicationRecord
  validates :name, presence: true
  validates :answer, presence: true
  validates :decision_id, presence: true

  belongs_to :decision

  def contract_link
    Contract.find(Decision.find(self.decision_id).contract_id).link
  end
end
