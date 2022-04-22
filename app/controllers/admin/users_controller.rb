class Admin::UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit  destroy ]
  before_action :login_required

 def index 
  @users = User.all
  unless  current_user.id && current_user.admin == "管理者"
    
    redirect_to tasks_path, flash[:notice]= "管理者以外はアクセスできません"
  end

 end
 
 def new
   @user = User.new
 end

 def create 
   @user=User.new(user_params)
   if @user.save
     redirect_to admin_users_path
   else
     redirect_to action: :new
  end
 end



 def edit
 end

 def show
  @tasks = Task.all.includes(:user)
  @tasks = @tasks.page(params[:page]).per(5)
end



 private 
  def user_params
   params.require(:user).permit(:id,:name, :email,:password, :password_confirmation,:admin )
  end
 
  def set_user
   @user=User.find(params[:id])
  end

 def login_required
    unless current_user.admin == "管理者"
     redirect_to(tasks_url)
     flash[:notice] = '管理者専用ページです'
   end
 end

end