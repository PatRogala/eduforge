# Represents a user (client) in system
# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  has_many :user_roles, dependent: :delete_all
  has_many :roles, through: :user_roles

  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :email, presence: true, uniqueness: true
  validates :encrypted_password, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def instructor?
    roles.ids.include?(Role::INSTRUCTOR_ID)
  end
end
