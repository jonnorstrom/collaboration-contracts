class Decision < ApplicationRecord
  validates :contract_id, presence: true
  validates :description, presence: true

  has_many :answers, :dependent => :destroy
  belongs_to :contract

  def user_answer_type?(type, user)
      self.answers.exists?(answer: type, name: user)
  end

end
