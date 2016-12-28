class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_contracts
  has_many :contracts, through: :user_contracts
  has_many :answers

  def users_name
    "#{self.first_name} #{self.last_name[0].capitalize}."
  end

end
