class Answer < ApplicationRecord
  validates :name, presence: true
  validates :answer, presence: true
  validates :decision_id, presence: true

  belongs_to :decision
end
