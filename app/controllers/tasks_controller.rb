class TasksController < ApplicationController
  before_action :require_site

  def index
    @tasks = current_site.tasks.order(priority: :desc, created_at: :desc).group_by(&:status)
  end

  def create
    task = current_site.tasks.new(title: params[:title], priority: 2, status: "todo", creator: current_user)

    if task.save
      redirect_to tasks_path, notice: "Задача «#{task.title}» добавлена в план"
    else
      redirect_back fallback_location: tasks_path, alert: "Не получилось добавить задачу"
    end
  end

  def update
    task = current_site.tasks.find(params[:id])
    task.update(status: params[:status]) if Task::STATUSES.key?(params[:status])
    redirect_to tasks_path
  end

  private

  def require_site
    redirect_to new_onboarding_path, alert: "Сначала подключите сайт" unless current_site
  end
end
