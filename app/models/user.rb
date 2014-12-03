class User < ActiveRecord::Base

  devise :cas_authenticatable, :trackable

#  before_validation :map_user

  #validates :username, :uniqueness => true
  #validates_presence_of :username

  def name
    "#{first_name} #{last_name}"
  end

  def username
    self[:username].to_s.downcase.strip
  end

  protected

  def map_user
    MapUserToApi.call(self)
  end

end
