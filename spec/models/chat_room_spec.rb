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

require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  context 'パラメータが正常な場合' do
    it 'バリデーションが通る' do
      expect(build(:chat_room)).to be_valid
    end

    it 'DBへ登録される' do
      expect { create(:chat_room) }.to change(ChatRoom, :count).by(1)
    end
  end

  context 'パラメータが正しくない場合' do
    context 'titleがnilの場合' do
      it 'バリデーションが通らない' do
        expect(build(:chat_room, title: nil)).not_to be_valid
      end
    end
  end
end
