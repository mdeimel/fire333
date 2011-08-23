class AttachmentController < ApplicationController
  before_filter :loggedin?, :except => [:show]
  
  def show
    @attachment = Attachment.find(params[:id])
    send_data @attachment.data, :filename => @attachment.filename, :type => @attachment.content_type
  end

  def create  
    if params[:attachment].blank?
      return redirect_to :action => "index" 
    end
    @attachment = Attachment.new
    params[:attachment]
    @attachment.uploaded_file = params[:attachment]
    @attachment.displayname = params[:displayname]
    @attachment.description = params[:description]
    @attachment.user_id = session[:user_id]
    if @attachment.save
        flash[:notice] = "Attachment submitted successfully."
    else
    debugger
        flash[:error] = "There was a problem submitting your attachment. " + @attachment.errors
    end
    redirect_to root_path
  end

  def destroy
    attachment = Attachment.find(params[:id])
    if attachment.user_id==session[:user_id]
      attachment.destroy
      flash[:notice] = "Attachment deleted."
    else
      flash[:error] = "Attachments can only be deleted by the user who created them."
    end
    redirect_to root_path
  end
end
