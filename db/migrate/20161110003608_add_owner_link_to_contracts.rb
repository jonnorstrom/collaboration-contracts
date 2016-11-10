class AddOwnerLinkToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :owner_link, :string
  end
end
