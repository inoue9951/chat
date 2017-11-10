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

FactoryGirl.define do
  factory :chat_room do
    title 'SampleTitle'
    description 'Sample Chat Room'
  end

  factory :invalid_chat_room, class: ChatRoom do
    title nil
    description 'Invalid params'
  end
end
