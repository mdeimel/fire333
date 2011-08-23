class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :content, :user_id
  #scope :next, lambda { |id| {:conditions => ["id < ?", id], :limit => 1, :order => "id DESC"} }
  
  def next
    Post.find(:first, :conditions => ["id < ?", self.id], :order => "id DESC")
  end
  
  def prev
    Post.find(:first, :conditions => ["id > ?", self.id], :order => "id ASC")
  end
end
