class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :title, :content, :user_id
end
