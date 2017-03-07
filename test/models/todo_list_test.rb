require 'test_helper'

class TodoListTest < ActiveSupport::TestCase

  def setup
    @user = users(:john)
    # This code is not idiomatically correct.
    @todo_list = @user.todo_lists.build(title: "Lorem ipsum")
  end

  test "should be valid" do
    assert @todo_list.valid?
  end

  test "user id should be present" do
    @todo_list.user_id = nil
    assert_not @todo_list.valid?
  end

  test "title should be present" do
    @todo_list.title = "   "
    assert_not @todo_list.valid?
  end

  test "title should be at most 140 characters" do
    @todo_list.title = "a" * 141
    assert_not @todo_list.valid?
  end

end
