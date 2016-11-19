class RemoveThemesTable < ActiveRecord::Migration[5.0]
  def change
    drop_table :themes
    remove_column :contracts, :theme_id
    add_column :contracts, :theme, :string
  end
end
