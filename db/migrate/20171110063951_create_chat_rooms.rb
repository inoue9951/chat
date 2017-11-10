class CreateChatRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_rooms do |t|
      t.string :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
