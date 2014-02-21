class User < ActiveRecord::Base
  attr_accessible :authority, :password_digest, :login, :password_confirmation, :password
  validates :login, presence: true, uniqueness: true
  validates :authority, :presence => true
  has_secure_password
  has_many :projects
end
