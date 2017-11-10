module UsersHelper
  def join?(room, my_chat_list)
    my_chat_list.include? room
  end
end
