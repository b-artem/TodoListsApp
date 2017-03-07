class TasksController < ApplicationController

  before_action :require_user

  def index
  end

  def new
  end

  def create
    @todo_list = TodoList.find(params[:todo_list_id])
    body = params[:task][:body]
    # The lowest priority by default, the highest is 0
    if @todo_list.tasks.any?
      priority = @todo_list.tasks.maximum(:priority) + 1
    else
      priority = 0
    end
    done = false
    deadline = Date.today.advance(days: 7)
    @task = @todo_list.tasks.build(body: body, priority: priority, done: done, deadline: deadline)
    if @task.save
      #flash[:success] = "Task created!"
      render 'create_task'
    else
      flash[:warning] = "Task wasn't created!"
      #redirect_to root_url
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update_attributes(task_params)
      #flash[:success] = "Task changed"
      render 'clear_task_form'
    else
      flash[:success] = "Task hasn't been changed"
    end
  end

  def destroy
    Task.destroy(params[:id])
    #flash[:success] = "Task deleted"
    render js: "$('#task-#{params[:id]}').remove();"
  end

  def priority_up
    @task = Task.find(params[:id])
    @task_up = Task.find(params[:id])
    @tdl = TodoList.find(@task_up.todo_list_id)
    if @task_up.priority > @tdl.tasks.minimum(:priority)
      @task_down = @task_up.prev
      pr_up = @task_down.priority
      pr_down = @task_up.priority
      if @task_up.update_attributes(priority: pr_up) && @task_down.update_attributes(priority: pr_down)
        render 'priority_up'
      else
        flash[:warning] = "Priorities hasn't been changed"
      end
    else
      flash[:warning] = "Task already has the highest priority"
    end
  end

  def priority_down
    @task = Task.find(params[:id])
    @task_down = Task.find(params[:id])
    @tdl = TodoList.find(@task_down.todo_list_id)
    if @task_down.priority < @tdl.tasks.maximum(:priority)
      @task_up = @task_down.next
      pr_down = @task_up.priority
      pr_up = @task_down.priority
      if @task_up.update_attributes(priority: pr_up) && @task_down.update_attributes(priority: pr_down)
        render 'priority_down'
      else
        flash[:warning] = "Priorities hasn't been changed"
      end
    else
      flash[:warning] = "Task already has the lowest priority"
    end
  end

  def change_state
    @task = Task.find(params[:id])
    done = !@task.done
    if @task.update_attributes(done: done)
      render 'change_state'
    else
      flash[:warning] = "State hasn't been changed"
    end
  end

  private
    def task_params
      params.require(:task).permit(:body, :priority, :done, :deadline)
    end

    #   def set_task
    #     @task = Task.find(params[:id])
    #   end

end
