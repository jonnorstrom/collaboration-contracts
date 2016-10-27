class AddDecisionToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :decision, :string
  end
end
