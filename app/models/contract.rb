class Contract < ApplicationRecord
  validates :title, presence: true
  validates :link, presence: true
  validates :owner_link, presence: true
  validates :user_id, presence: true

  has_many :decisions
  belongs_to :user

  def owner?(user_id)
    self.user_id == user_id
  end
end
