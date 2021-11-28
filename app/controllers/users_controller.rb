class UsersController < ApplicationController


  def index
    @users = User.all
    @user = current_user
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user.id)
    if User.find(params[:id]).id == current_user.id
      @user = User.find(params[:id])
    else
      flash[:alert] = "error! You are not allowed to edit other user's info"
      redirect_to(user_path(current_user.id))
    end
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "User data was successfully updated"
      redirect_to(user_path(current_user.id))
    else
      err_msg = "error! Failed to update data.\n"
      @user.errors.full_messages.each do |msg|
        err_msg += msg + "\n"
      end

      flash[:alert] = err_msg
      render(action: "edit")
    end
  end

  private
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end

end