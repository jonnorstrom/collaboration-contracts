class Contract < ApplicationRecord
  validates :title, presence: true
  validates :link, presence: true
  has_many :decisions
end
