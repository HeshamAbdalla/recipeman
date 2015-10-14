class User < ActiveRecord::Base
  has_secure_password
  attr_accesor :password
  has_many :recipes
  has_many :likes
  before_save { self.email = email.downcase}
  validates :chefname, presence: true, length:{minimum: 2, maximum:10}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum:105},
                                    uniqueness: {case_sensitive: false},
                                    format: { with: VALID_EMAIL_REGEX }

end
