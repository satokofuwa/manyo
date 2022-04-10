class TasksController < ApplicationController
    before_action :set_task, only: %i[show edit update destroy ]
  
    def index
      @tasks = Task.all
    end
  
    def new
      @task = Task.new
    end
  
    def edit
      @task = Task.find(params[:id])
    end
    
    def create
      @task = Task.new(task_params)
        if @task.save!
          redirect_to tasks_url, notice: "Task was successfully created." 
        else
          redirect_to tasks_url, notice: "An error has occurred." 
        end
    end
  
    def update
      if @task.update(task_params)   
        redirect_to tasks_url, notice: "Task has been successfully updated." 
      else
        redirect_to edit_task_url,notice: "An error has occered"
      end
    end
    
    def show 
      @tasTks = Task.all
    end
  
    def destroy
      if @task.present?
           @task.destroy
        redirect_to tasks_url, notice:  "Task has been deleted!"
      end
    end 
  
    private
  
    def set_task
      @task = Task.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:title, :content)
    end
  end
