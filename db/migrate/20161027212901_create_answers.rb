class CreateAnswers < ActiveRecord::Migration[5.0]
  def change
    create_table :answers do |t|
      t.string :name
      t.string :answer
      t.string :link

      t.timestamps
    end
  end
end
