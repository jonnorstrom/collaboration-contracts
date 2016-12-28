class UpdateUserContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :user_contracts, :user_id, :integer
    add_column :user_contracts, :contract_id, :integer
    add_column :user_contracts, :owner, :boolean, default: false
  end
end
