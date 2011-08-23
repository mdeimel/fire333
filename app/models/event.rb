class Event < ActiveRecord::Base
  belongs_to :user
  validates :title, :presence => {:message => "Title is required."}
  validates :location, :presence => {:message => "Location is required."}
  validates :start, :presence => {:message => "Start time is required. "}
  # :end doesn't have to be specified
  
  scope :recent, order("start DESC").where("start < ?", Date.today).limit(2)
  scope :upcoming, order("start ASC").where("start >= ?", Date.today).limit(4)
  
  def after_find
    self.start+=Time.zone_offset('CDT')
    # There should not be an attribute named "end", it will be confused with end of line/method keyword
    self["end"]+=Time.zone_offset('CDT')
  end
end
