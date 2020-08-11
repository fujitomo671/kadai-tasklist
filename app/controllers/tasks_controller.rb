class TasksController < ApplicationController
  before_action :restrict_user
  
  def index
    @tasks = current_user.tasks.all
  end

  def show
    @task = current_user.tasks.find(params[:id])
    # @task = Task.find(params[:id])
  end

  def new
    @task = current_user.tasks.build
    # task = {. status: '', user_id: current_user.id  }
  end

  def create
    # message_parans が入っていてエラーが発生していた
    @task = current_user.tasks.build(task_params)

    if @task.save
      flash[:success] = 'Task が正常に追加されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task が追加されませんでした'
      render :new
    end
  end

  def edit
    # TODO, 上記を参考に
    @task = current_user.tasks.find(params[:id])
  end

  def update
    # TODO, 上記を参考に
    @task = current_user.tasks.find(params[:id])

    if @task.update(task_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @task
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    # TODO, 上記を参考に
    @task = current_user.tasks.find(params[:id])
    @task.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  private

  # Strong Parameter
  def task_params
    params.require(:task).permit(:content, :status)
  end
end
