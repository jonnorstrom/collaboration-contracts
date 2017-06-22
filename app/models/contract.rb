class Contract < ApplicationRecord
  validates :title, presence: true
  validates :link, presence: true
  validates :owner_link, presence: true
  validates :viewer_link, presence: true
  # validates :user_id, presence: true

  has_many :decisions, :dependent => :delete_all
  has_many :user_contracts, :dependent => :delete_all
  has_many :users, through: :user_contracts
  belongs_to :creator, :class_name => 'User'

  def owner?(user)
    self.user_contracts.exists?(owner: true, user_id: user.id, contract_id: self.id)
  end

  def collaborator?(user)
    self.user_contracts.exists?(owner:false, viewer: false, user_id: user.id, contract_id: self.id)
  end

  def viewer?(user)
    self.user_contracts.exists?(viewer: true, user_id: user.id, contract_id: self.id)
  end

  def self.find_which_by(params)
    Contract.find_by_link(params) || Contract.find_by_owner_link(params) || Contract.find_by_viewer_link(params)
  end

  def set_user_contract(hash_link, user)
    if hash_link == self.owner_link
      self.set_owner(user)
    elsif hash_link == self.link
      UserContract.find_or_create_by(user_id: user.id, contract_id: self.id)
    elsif hash_link == self.viewer_link
      UserContract.find_or_create_viewer(user, self)
    end
  end

  def toggle_task(task)
    if task == "review"
      self.toggle_review
    elsif task == "complete"
      self.toggle_complete
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

  def self.find_by_viewer_link(params)
    Contract.find_by(id: params[:id], viewer_link: params[:link])
  end

  def user_list(current_user)
    user_list = []
    self.users.each do |user|
      user == current_user ? user_list.push("You") : user_list.push(user.users_name.chomp("."))
    end
    return user_list.join(", ")
  end

  def path
    return "/contracts/#{self.id}/#{self.link}"
  end

  def set_owner(user)
    if @user_contract = UserContract.where(user_id: user.id, contract_id: self.id).first
      @user_contract.update(owner: true)
    else
      UserContract.create_owner_join(user, self)
    end
  end
end
