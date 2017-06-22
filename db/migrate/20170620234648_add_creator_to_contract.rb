class AddCreatorToContract < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :creator_id, :integer
  end
end
