class UsersController < ApplicationController
  before_action :set_user, :check_admin, only: %i[ show edit ]
  skip_before_action :login_required, only: [:new, :create]  
  
<<<<<<< HEAD
    def new
      @user = User.new
    end        
=======
  def new
    if logged_in?
      redirect_to tasks_path
    end
    @user = User.new
  end        
>>>>>>> step5
    
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

<<<<<<< HEAD
    def update
      respond_to do |format|
        @user = User.find(params[:id])
          if @user.update(user_params)     
            format.html { redirect_to user_url(@user), notice: "User was successfully updated." }
            format.json { render :show, status: :ok, location: @user }
          else
            format.html { render :edit, status: :unprocessable_entity }
            format.json { render json: @user.errors, status: :unprocessable_entity }
          end
      end
    end
            
    def show
      @tasks = Task.where(user_id: @user.id)
    end
           
    def edit
    end

    def destroy
      if User.find(params[:id]).destroy
        redirect_to admin_users_path
      else
        redirect_to admin_users_path
      end
=======
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
    unless current_user.id == @user.id then
        redirect_to tasks_path, notice: '他人のページへアクセスはできません'
    end

  end
           
  def edit
  end

  def destroy
    if User.find(params[:id]).destroy
      redirect_to admin_users_path
      flash[:notice] = "#{User.find(params[:id]).name}を削除しました"
   
>>>>>>> step5
    end


  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin,tasks_attributes: [ :title, :content, :expired, :status, :priority, :user_id ])
  end

  def set_user
    @user = User.find(params[:id])
  end

  def check_admin
    unless @user.id == current_user.id || current_user.admin == "管理者"
      redirect_to tasks_path, flash[:notice]= "管理者以外はアクセスできません"
    end
  end

end