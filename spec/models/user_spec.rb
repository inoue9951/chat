# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)      not null
#  user_id         :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_users_on_user_id  (user_id) UNIQUE
#

require 'rails_helper'

RSpec.describe User, type: :model do
  context 'パラメータが正常な場合' do
    it 'バリデーションが通る' do
      expect(build(:user)).to be_valid
    end

    it 'DBへ登録される' do
      expect { create(:user) }.to change { User.count }.by(1)
    end
  end

  context 'nameが存在しない場合' do
    it 'バリデーションが通らない' do
      expect(build(:user, name: nil)).not_to be_valid
    end
  end

  context 'user_idが存在しない場合' do
    it 'バリデーションが通らない' do
      expect(build(:user, user_id: nil)).not_to be_valid
    end
  end

  context 'user_idの長さが8より小さい場合' do
    it 'バリデーションが通らない' do
      expect(build(:user, user_id: 'aaa')).not_to be_valid
    end
  end

  context 'user_idが重複している場合' do
    it 'バリデーションが通らない' do
      create(:user)
      expect(build(:user)).not_to be_valid
    end
  end

  context 'passwordが存在しない場合' do
    it 'バリデーションが通らない' do
      expect(build(:user, password: nil)).not_to be_valid
    end
  end

  context 'password_cofirmationが存在しない場合' do
    it 'バリデーションが通らない' do
      expect(build(:user, password_confirmation: nil)).not_to be_valid
    end
  end

  context 'passwordとpassword_confirmationが異なる場合' do
    it 'バリデーションが通らない' do
      expect(build(:user, password: 'aaaaaaaa', password_confirmation: 'bbbbbbbb')).not_to be_valid
    end
  end

  context 'passwordの長さが8より小さい場合' do
    it 'バリデーションが通らない' do
      expect(build(:user, password: 'aaaaaaa', password_confirmation: 'aaaaaaa')).not_to be_valid
    end
  end
end
