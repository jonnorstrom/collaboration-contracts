class Name < ActiveRecord::Migration[5.0]
  def change
    add_column :answers, :contract_id, :integer
    remove_column :answers, :link, :string
  end
end
