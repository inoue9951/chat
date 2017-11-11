class ChatRoomsController < ApplicationController
  before_action :require_login

  def new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    if @chat_room.save
      user = User.find(session[:id])
      user.chat_rooms << @chat_room
      redirect_to @chat_room
    else
      flash.now[:danger] = 'タイトルを入力してください'
      render :new
    end
  end

  def show
    @user = current_user
    @chat_room = ChatRoom.find(params[:id])
  end

  def update
    chat_room = ChatRoom.find(params[:id])
    unless chat_room.users.exists?(id: session[:id])
      chat_room.users << User.find(session[:id])
    end
    redirect_to chat_room
  end

  def destroy
    chat_room = ChatRoom.find(params[:id])
    if chat_room.destroy
      redirect_to controller: :users, action: :show, id: session[:id]
    else
      render controller: :users, action: :show, id: session[:id]
    end
  end

  def leave
    chat_room = ChatRoom.find(params[:id])
    user = chat_room.users.find_by(id: session[:id])
    chat_room.users.delete(user) unless user.nil?
    redirect_to controller: :users, action: :show, id: session[:id]
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, :description)
  end
end
