class ChatRoomsController < ApplicationController
  def new
  end

  def create
    @chat_room = ChatRoom.new(chat_room_params)
    if @chat_room.save
      redirect_to @chat_room
    else
      flash.now[:danger] = 'タイトルを入力してください'
      render :new
    end
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, :description)
  end
end
