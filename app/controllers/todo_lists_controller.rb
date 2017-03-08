class TodoListsController < ApplicationController

  before_action :require_user


  def index
    @todo_lists = current_user.todo_lists
    @todo_list = TodoList.new if logged_in?
  end

  def new
  end

  def create
    @todo_list = current_user.todo_lists.build(title: "Project ")
    @todo_list.title += (current_user.todo_lists.count + 1).to_s
    if @todo_list.save
      flash.now[:success] = "TODO list created!"
      redirect_to root_url
    else
      flash[:warning] = "TODO list wasn't created!"
    end
  end

  def show
  end

  def edit
    @todo_list = TodoList.find(params[:id])
  end

  def update
    @todo_list = TodoList.find(params[:id])
    if @todo_list.update_attributes(todo_list_params)
      #flash[:success] = "Title changed"
      render 'clear_todo_list_form'
    else
      flash[:warning] = "Title hasn't been changed"
    end
  end

  def destroy
    render js: "$('#todo-list-#{params[:id]}').remove();"
    TodoList.destroy(params[:id])
    #flash.now[:success] = "Todo list deleted"
  end

    private

      def todo_list_params
        params.require(:todo_list).permit(:title)
      end

      # def set_todo_list
      #   @todo_list = TodoList.find(params[:id])
      # end

end
