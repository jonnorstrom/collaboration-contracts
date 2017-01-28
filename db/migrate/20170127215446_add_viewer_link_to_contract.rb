class AddViewerLinkToContract < ActiveRecord::Migration[5.0]
  def change
    add_column :contracts, :viewer_link, :string
  end
end
