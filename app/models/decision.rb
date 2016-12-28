class Decision < ApplicationRecord
  validates :contract_id, presence: true
  validates :description, presence: true

  has_many :answers, :dependent => :destroy
  belongs_to :contract

  # this is used to pre-check radio_button on answer modal
  def user_answer_type?(type, user)
      self.answers.exists?(answer: type, user: user)
  end

end
