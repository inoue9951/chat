class CreateChatRoomsUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_rooms_users, id: false do |t|
      t.references :user, foreign_key: true, null: false, index: true
      t.references :chat_room, foreign_key: true, null: false, index: true
    end
  end
end
