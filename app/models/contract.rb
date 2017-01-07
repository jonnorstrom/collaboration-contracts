class Contract < ApplicationRecord
  validates :title, presence: true
  validates :link, presence: true
  validates :owner_link, presence: true
  # validates :user_id, presence: true

  has_many :decisions, :dependent => :delete_all
  has_many :user_contracts, :dependent => :delete_all
  has_many :users, through: :user_contracts

  def owner?(user)
    self.user_contracts.where(owner: true).include? UserContract.where(user_id: user.id, contract_id: self.id).first
  end

  def self.find_which_by(params)
    Contract.find_by_link(params) || Contract.find_by_owner_link(params)
  end

  def set_user_contract(hash_link, user)
    if hash_link == self.owner_link
      self.set_owner(user)
    elsif hash_link == self.link
      UserContract.find_or_create_by(user_id: user.id, contract_id: self.id)
    end
  end

  def toggle_complete
    self.toggle(:complete)
  end

  def toggle_review
    self.toggle(:reviewable)
  end

  def self.find_by_link(params)
    Contract.find_by(id: params[:id], link: params[:link])
  end

  def self.find_by_owner_link(params)
    Contract.find_by(id: params[:id], owner_link: params[:link])
  end

  def user_list(current_user)
    user_list = []
    self.users.each do |user|
      user == current_user ? user_list.push("You") : user_list.push(user.users_name.chomp("."))
    end
    return user_list.join(", ")
  end

  def team_url
    
  end

  def set_owner(user)
    if @user_contract = UserContract.where(user_id: user.id, contract_id: self.id).first
      @user_contract.update(owner: true)
    else
      UserContract.create_owner_join(user, self)
    end
  end
end
