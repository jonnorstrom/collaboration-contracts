class UserContract < ApplicationRecord

  belongs_to :user
  belongs_to :contract

  def self.create_owner_join(user, contract)
    UserContract.create(user_id: user.id, contract_id: contract.id, owner: true)
  end

  def self.owner_contracts(current_user)
    current_user.contracts.select {|contract| contract.owner?(current_user)}
  end

  def self.users_contracts(current_user)
    current_user.contracts.select {|contract| !contract.owner?(current_user)}
  end
end
