class Decision < ApplicationRecord
  validates :contract_id, presence: true
  validates :description, presence: true
  has_many :answers
  belongs_to :contract
end
