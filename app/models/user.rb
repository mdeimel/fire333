class User < ActiveRecord::Base
  # Only allow the following attributes to be set by mass assignment
  # password_confirmation MUST be here to work with validates_confirmation_of
  attr_accessible :login_name, :display_name, :password, :password_confirmation

  validates_presence_of :login_name, :password, :message => "Can't be blank. "
  validates_presence_of :display_name, :password, :message => "Can't be blank. "
  validates_uniqueness_of :login_name, :case_sensitive => false, :message => "Name Is Not unique. "
  validates_uniqueness_of :display_name, :case_sensitive => false, :message => "Display Name Is Not unique. "
  validates_confirmation_of :password, :message => "The password must be the same in both fields. "
  validates_length_of :password, :minimum => 8, :message => "The password must be 8 characters or more. "
  
  has_many :posts
  has_many :events
  has_many :attachments
  
  def before_save
    hash_password if self.salt.nil?
  end
  
  def self.authenticate login_name, password
    # TODO Test this for SQL injection
    return nil unless !login_name.nil? && !password.nil? && login_name != "" && password != ""
    # Hashing and Salting password
    user = User.find(:first, :conditions => ['UPPER(login_name) = ?', login_name.upcase])
    if !user.nil?
      if (hash_data(password, user.salt) == user.password)
        return user
      else
        return nil
      end
    end
    return nil
  end
  
  def change_password password, confirm_password
    if password==confirm_password
      self.password=password
      self.hash_password
      return true
    else
      self.errors.add_to_base "Passwords do not match"
      return false
    end
  end
  
  protected
  
  def create_salt
    self.salt = User.hash_data("#{Time.now}#{self.login_name}")
  end
  
  def hash_password
    create_salt unless !self.salt.nil?
    self.password = User.hash_data(self.password, self.salt)
  end

  def self.hash_data(data, salt = "")
    Digest::MD5.hexdigest("#{data}#{salt}")
  end
end
