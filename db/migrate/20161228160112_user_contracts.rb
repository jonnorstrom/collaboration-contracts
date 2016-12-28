class UserContracts < ActiveRecord::Migration[5.0]
  def change
    create_table :user_contracts do |t|

      t.timestamps
    end
  end
end
