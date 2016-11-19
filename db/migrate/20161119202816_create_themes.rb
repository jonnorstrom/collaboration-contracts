class CreateThemes < ActiveRecord::Migration[5.0]
  def change
    create_table :themes do |t|
      t.string :theme

      t.timestamps
    end
    add_column :contracts, :theme_id, :integer
  end
end
