class TasksController < ApplicationController
    before_action :set_task, only: %i[show edit update destroy ]
  
    def index
      @tasks = Task.order(created_at: :desc)
        #曖昧検索
        if params[:task].present?
          if params[:task][:search].present? && params[:task][:status].blank?
            @tasks = @tasks.keyword(params[:task][:search])
          elsif 
            params[:task][:status].present? && params[:task][:search].blank?
            @tasks = @tasks.status_select(params[:task][:status])
          elsif
            params[:task][:search].present? && params[:task][:status].present?
            @tasks = @tasks.keyword_status(params[:task][:search],params[:task][:status])
          end
        elsif
          params[:sort_expired] 
          @tasks = Task.order(expired_at: :desc)
        elsif 
          params[:priority_sort]
          @tasks = @tasks.priority_sort
        end
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
      @tasks = Task.all
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
      params.require(:task).permit(:title, :content,:expired_at,:status,:priority)
    end
  end
