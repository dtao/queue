class TasksController < ApplicationController
  def index
    @task = current_user.tasks.pending.first
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.create(task_params)

    if @task.save
      alert('Task saved successfully.')
      redirect_to(tasks_path)

    else
      alert('Error saving task.', :error)
      render(:action => 'new')
    end
  end

  def complete
    @task = Task.find(params[:id])
    @task.completed_at = Time.now
    @task.save!
    alert('Task completed.')
    redirect_to(tasks_path)
  end

  def pass
    @task = Task.find(params[:id])
    @task.touch
    alert('Procrastination successful :)')
    redirect_to(tasks_path)
  end

  private

  def task_params
    params.require(:task).permit(:description, :comments)
  end
end
