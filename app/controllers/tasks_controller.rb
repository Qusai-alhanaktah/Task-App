class TasksController < ApplicationController
  before_action :authenticate_user!, except: :index
  def index
    if params[:search]
      @tasks = Task.search(params[:search]).order("created_at DESC")
    else
      @tasks = Task.all.order('created_at DESC')
    end
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    # byebug
    if @task.update(task_params)
      if params[:commit] == 'Update Task'
        redirect_to generate_path
      else
        redirect_to root_path
      end
    else
      render 'edit'
    end
  end

  def show
    @task = Task.find(params[:id])
  end
  
  def generate
    @task = Task.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "app/views/tasks/generate.html.haml"   # Excluding ".pdf" extension.
      end
    end
    render pdf: 'generate.html.haml', header: { right: '[page] of [topage]' }
  end

  def edit
    @task = Task.find(params[:id])
  end
  private def task_params
    params.require(:task).permit(:name, :description, :image)
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path
  end
end
