class AddReviewableToContracts < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :reviewable, :boolean, default: false
  end
end
