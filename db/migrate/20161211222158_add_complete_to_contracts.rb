class AddCompleteToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :complete, :boolean, default: false
  end
end
