class Admin::UsersController < Admin::BaseController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    # assuming only the admin status is modifiable!
    @user = User.find(params[:id])
    if params[:toggle] == 'notifs'
      @user.toggle!(:receives_notifs)
    else
      @user.toggle!(:admin)
    end
    redirect_to :back
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to admin_users_path
    end
  end

end
