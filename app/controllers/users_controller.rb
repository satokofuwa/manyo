class UsersController < ApplicationController
  before_action :set_user, :check_user, only: %i[ show edit ]
  skip_before_action :login_required, only: [:new, :create]  
  
  def new
    if logged_in?
      redirect_to tasks_path
    end
      @user = User.new
  end        
    
  def create
    @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        flash[:notice] ='ログインしました'
        redirect_to user_path(@user.id),notice: "ユーザー「#{@user.name}」を登録しました。"
      else
        render :new
      end
  end

  def update
      @user = User.find(params[:id])
      if @user.update(user_params)     
         redirect_to tasks_url
        flash[:notice] = "ユーザー情報が更新されました"      
      else
        redirect_to tasks_url
        flash[:notice] = "管理者一人の為更新できません" 
      end
  end
            
  def show
    @tasks = Task.where(user_id: @user.id)
  end
           
  def edit
  end

  def destroy
    if User.find(params[:id]).destroy
      respond_to do |format|
        format.html { redirect_to tasks_url, notice: 'ユーザーを削除しました！' }
        format.json { head :no_content }
      end
    end 
  end
  
  private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin,tasks_attributes: [ :title, :content, :expired, :status, :priority, :user_id ])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_user
    if @user.id != current_user.id
      redirect_to tasks_path, notice: '管理者以外はアクセスできません'
    end
  end
end