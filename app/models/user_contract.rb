# Join table for users and contracts
class UserContract < ApplicationRecord

  belongs_to :user
  belongs_to :contract

  def self.create_owner_join(user, contract)
    UserContract.create(user_id: user.id, contract_id: contract.id, owner: true)
  end

  def self.create_or_update(user, contract, position_string)
    position_string == "Viewer" ? viewer = true : viewer = false
    position_string == "Owner" ? owner = true : owner = false
    if user_contract = UserContract.where(user_id: user.id, contract_id: contract.id).first
      user_contract.owner = owner
      user_contract.viewer = viewer
      user_contract.save
    else
      UserContract.create(user_id: user.id, contract_id: contract.id, viewer: viewer, owner: owner)
    end
  end

  def self.find_or_create_viewer(user, contract)
    if @user_contract = UserContract.where(user_id: user.id, contract_id: contract.id).first
      @user_contract.viewer = true
     else
      UserContract.create(user_id: user.id, contract_id: contract.id, viewer: true)
    end
  end

  def self.owner_contracts(current_user)
    current_user.contracts.select {|contract| contract.owner?(current_user)}.sort! { |a,b| a.id <=> b.id }
  end

  def self.users_contracts(current_user)
    current_user.contracts.select {|contract| contract.collaborator?(current_user)}.sort! { |a,b| a.id <=> b.id }
  end

  def self.viewer_contracts(current_user)
    current_user.contracts.select {|contract| contract.viewer?(current_user)}.sort! { |a,b| a.id <=> b.id }
  end
  private
end
