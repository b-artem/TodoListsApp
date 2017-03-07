class AddIndexToTodoLists < ActiveRecord::Migration[5.0]
  def change
    add_index :todo_lists, :created_at
  end
end
