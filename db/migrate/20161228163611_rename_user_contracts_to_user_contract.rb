class RenameUserContractsToUserContract < ActiveRecord::Migration[5.0]
  def change
    rename_table :user_contracts, :user_contract
  end
end
