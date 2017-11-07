class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(user_id: params[:session][:user_id])
    if @user&.authenticate(params[:session][:password])
      log_in @user
      redirect_to @user
    else
      flash.now[:danger] = '入力内容に誤りがあります'
      render 'new'
    end
  end

  def destroy
  end
end
