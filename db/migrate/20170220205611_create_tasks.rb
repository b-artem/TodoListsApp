class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :body
      t.boolean :done
      t.integer :priority
#      t.references :todo_list, foreign_key: true

      t.timestamps
    end
  end
end
