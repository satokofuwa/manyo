class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy ]
  before_action :check_user,only: :show
  
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
        @tasks=@tasks.page(params[:page]).per(10)
      
    end
  
    def new
      @task = Task.new
    end

    def confirm
      @task = current_user.tasks.new(task_params)
      redirect_to new_task_url  if @task.invalid?
    end

    def edit
      @task = Task.find(params[:id])
    end
    
    def create
      @task = current_user.tasks.new(task_params)
        if @task.save
          flash[:notice] = "登録が完了しました。"
          redirect_to new_task_url
        else
          flash[:notice] = "エラーが発生しました。"
          redirect_to new_task_url
        end
    end
  
    def update
      if @task.update(task_params)   
        redirect_to tasks_url, notice: "タスクが更新されました" 
      else
        redirect_to edit_task_url,notice: "エラーが発生しました"
      end
    end
    
    def show 
      @tasks = Task.all.select(:id, :titile, :content)
    end
  
    def destroy
      if @task.present?
        @task.destroy
        redirect_to tasks_url, notice:  "タスクが削除されました"
      end
    end 
  
    private
    def set_task
      @task = Task.find(params[:id])
    end
  
    def task_params
      params.require(:task).permit(:title, :content,:expired_at,:status,:priority,{ label_ids:[]})
    end

    def check_user
      @task = Task.find(params[:id])
      if current_user.id != @task.user_id
      # ログインしているユーザーのIDと投稿されているユーザーのIDが違っている場合
        redirect_to tasks_path, notice: '他人のページへアクセスはできません'
      end
    end
end
