class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_contracts
  has_many :contracts, through: :user_contracts
  has_many :answers
  has_many :created_contracts, class_name: 'Contract', foreign_key: 'creator_id'

  def users_name
    "#{self.first_name} #{self.last_name[0].capitalize}."
  end

end
