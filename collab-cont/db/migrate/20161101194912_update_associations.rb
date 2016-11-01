class UpdateAssociations < ActiveRecord::Migration[5.0]
  def change
    remove_column :answers, :contract_id, :integer
    add_column :answers, :decision_id, :integer
    remove_column :contracts, :decision, :string
  end
end
