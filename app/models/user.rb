class User < ActiveRecord::Base
  # Only allow the following attributes to be set by mass assignment
  # password_confirmation MUST be here to work with validates_confirmation_of
  attr_accessible :name, :password, :password_confirmation

  validates_presence_of :name, :password, :message => "Can't be blank. "
  validates_uniqueness_of :name, :case_sensitive => false, :message => "Not unique. "
  validates_confirmation_of :password, :message => "The password must be the same in both fields. "
  validates_length_of :password, :minimum => 8, :message => "The password must be 8 characters or more. "
  
  def before_save
    hash_password if self.salt.nil?
  end
  
  def self.authenticate name, password
    # TODO Test this for SQL injection
    return nil unless !name.nil? && !password.nil? && name != "" && password != ""
    # Hashing and Salting password
    user = User.find(:first, :conditions => ['UPPER(name) = ?', name.upcase])
    if !user.nil?
      if (hash_data(password, user.salt) == user.password)
        return user
      else
        return nil
      end
    end
    return nil
  end
  
  protected
  
  def create_salt
    self.salt = User.hash_data("#{Time.now}#{self.name}")
  end
  
  def hash_password
    create_salt unless !self.salt.nil?
    self.password = User.hash_data(self.password, self.salt)
  end

  def self.hash_data(data, salt = "")
    Digest::MD5.hexdigest("#{data}#{salt}")
  end
end
