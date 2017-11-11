class ChatRoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from 'chat_room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    user = User.find(data['id'])
    send_data = { message: data['message'], name: user.name }
    ActionCable.server.broadcast 'chat_room_channel', { data: send_data }
  end
end
