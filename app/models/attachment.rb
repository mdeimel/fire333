class Attachment < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :filename, :content_type, :data, :message => "Can't be blank. "
  
  # Get the smallest set of information - and specifically exclude
  # "data" field, as the query would be very expensive
  scope :select_all, select("id, displayname, description, content_type, user_id")

  def uploaded_file=(incoming_file)
    self.filename = incoming_file.original_filename
    self.content_type = incoming_file.content_type
    self.data = incoming_file.read
  end

  def filename=(new_filename)
    write_attribute("filename", sanitize_filename(new_filename))
  end
  
  def before_save
    if self.displayname.nil? || self.displayname.length==0
      self.displayname=self.filename
    end
  end

  private
  def sanitize_filename(filename)
    #get only the filename, not the whole path (from IE)
    just_filename = File.basename(filename)
    #replace all non-alphanumeric, underscore or periods with underscores
    just_filename.gsub(/[^\w\.\-]/, '_')
  end
end
