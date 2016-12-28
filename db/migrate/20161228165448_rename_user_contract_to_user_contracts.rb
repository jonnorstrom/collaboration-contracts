class RenameUserContractToUserContracts < ActiveRecord::Migration[5.0]
  def change
    rename_table :user_contract, :user_contracts
  end
end
