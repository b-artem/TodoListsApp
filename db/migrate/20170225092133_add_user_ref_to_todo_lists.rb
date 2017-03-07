class AddUserRefToTodoLists < ActiveRecord::Migration[5.0]
  def change
    add_reference :todo_lists, :user, foreign_key: true
  end
end
