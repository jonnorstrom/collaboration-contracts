class UserContract < ApplicationRecord

  belongs_to :user
  belongs_to :contract

  def self.create_owner_join(user, contract)
    UserContract.create(user_id: user.id, contract_id: contract.id, owner: true)
  end
end
