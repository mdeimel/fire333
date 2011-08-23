class SiteController < ApplicationController
  def index
    @post = params[:post_id].nil? ? Post.find(:last) : Post.find(params[:post_id])
    @next_post = @post.next
    @prev_post = @post.prev
    @upcoming_events = Event.upcoming
    @recent_events = Event.recent
    @attachments = Attachment.select_all
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def login
    user = User.authenticate params[:login_name], params[:password]
    if user.nil?
      flash[:error] = "Login name and password were not valid."
    else
      session[:login_name] = user.login_name
      session[:display_name] = user.display_name
      session[:user_id] = user.id
    end
    redirect_to root_path
  end
  
  def logout
    session.clear
    redirect_to root_path
  end
  
  def preferences
    user = User.find(:first, :conditions => ['login_name=?', session[:login_name]])
    # Change login_name
    if (!params[:new_login_name].nil? && params[:new_login_name].length>0)
      user.login_name = params[:new_login_name]
      user.save
      session[:login_name] = user.login_name
    end
    # Change display_name
    if (!params[:new_display_name].nil? && params[:new_display_name].length>0)
      user.display_name = params[:new_display_name]
      user.save
      session[:display_name] = user.display_name
    end
    # Change password
    if ((!params[:password].nil? && params[:password].length>0) && (!params[:confirm_password].nil? && params[:confirm_password].length>0))
      if (user.change_password params[:password], params[:confirm_password])
        user.save
      else
        flash[:error] = user.errors[:base][0]
      end
    end
    redirect_to root_path
  end
end
