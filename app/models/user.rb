class User < ActiveRecord::Base
  
  validates :username, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :zipcode, presence: true, on: :create, length: {minimum: 5} 
  validates :interest1, :city, :state, :free_time, presence: true, on: :create
  has_secure_password validations: false

  before_save :generate_slug

  def generate_slug 
    str = self.username
    str = str.strip
    str.gsub! /\s*[^A-Za-z0-9]\s*/, '-'
    str.gsub! /-+/, "-"
    self.slug = str.downcase 
  end

  def to_param
    self.slug
  end

end
