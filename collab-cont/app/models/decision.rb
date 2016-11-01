class Decision < ApplicationRecord
  has_many :answers
  belongs_to :contract
end
