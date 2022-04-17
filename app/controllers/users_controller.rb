class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  skip_before_action :login_required, only: [:new, :create]  
  def new
    @user = User.new
  end        
    
  def create
    @user = User.new(user_params)
      if @user.save
        redirect_to user_path(@user.id)
      else
        render :new
      end
  end

  def update
    respond_to do |format|
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
  #@user = User.find(params[:id])
  @tasks = Task.where(user_id: @user.id)
  end
           
  def edit
  end

  private 

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,tasks_attributes: [:task, :title, :content, :expired, :status, :priority, :user_id ])
  end

  def set_user
    @user = User.find(params[:id])
  end
end