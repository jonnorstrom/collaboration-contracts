class AddViewerToUserContract < ActiveRecord::Migration[5.0]
  def change
    add_column :user_contracts, :viewer, :boolean, default: false
  end
end
