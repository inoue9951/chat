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

class User < ApplicationRecord
  validates :name, presence: true
  validates :user_id, presence: true, uniqueness: true, length: { minimum: 8 }
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 }, confirmation: :password_confirmation
  validates :password_confirmation, presence: true, length: { minimum: 8 }

  has_and_belongs_to_many :chat_rooms
end
