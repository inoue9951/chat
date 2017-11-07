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

FactoryGirl.define do
  factory :user do
    name 'Taro'
    user_id 'sample_id'
    password 'sample_password'
    password_confirmation 'sample_password'
  end
end
