class UsersController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = '入力内容を確認してください'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @chat_list = ChatRoom.all
    @my_chat_list = @user.chat_rooms
  end

  private

  def user_params
    params.require(:user).permit(:name, :user_id, :password, :password_confirmation)
  end
end
