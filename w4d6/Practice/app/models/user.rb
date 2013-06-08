require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :password, :username

  validates :username, :presence => true,
  										 :uniqueness => true

  validates_format_of :username, :with => /\A\w+\Z/

  validates :password_digest, :presence => true

  has_many :shepherds, :class_name => Following, :foreign_key => :follower_id
  has_many :sheep, :class_name => Following, :foreign_key => :followed_id

  has_many :followers, :through => :sheep
  has_many :followed_users, :through => :shepherds, :source => :followed

  def password=(password)
  	self.password_digest = BCrypt::Password.create(password)
  end

  def password_valid?(password)
  	BCrypt::Password.new(self.password_digest) == password
  end

  def generate_session_token
  	self.session_token = SecureRandom.base64(16)
  	self.save
  end

end
