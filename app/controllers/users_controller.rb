class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @posts = @user.posts
  end
  def new
    @user= User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
     user = User.new(user_params)
    if user.save
        flash[:success] = 'You are registered!'
        redirect_to user_path user.id
    else
        flash[:error] = 'Registration has failed!'
        redirect_to new_user_path
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(params.require(:user).permit(user_params))
      redirect_to user_path
    else
      render 'edit'
    end
  end

  def destroy
  end

  private
    # Implement Strong Params
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end


end
