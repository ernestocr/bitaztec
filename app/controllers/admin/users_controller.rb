class Admin::UsersController < Admin::BaseController

  def index
    # list all users
    @users = User.all
  end

  def show
    # list user orders for helping overcome
    # possible problems
    @user = User.find(params[:id])
  end

  def destroy
    # don't forget to notify the user by email!
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path
    end
  end

end
