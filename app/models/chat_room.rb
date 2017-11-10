# == Schema Information
#
# Table name: chat_rooms
#
#  id          :integer          not null, primary key
#  title       :string(255)      not null
#  description :text(65535)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ChatRoom < ApplicationRecord
  validates :title, presence: true
end
