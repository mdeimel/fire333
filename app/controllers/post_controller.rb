class PostController < ApplicationController
  before_filter :loggedin?, :except => [:show]
  
  def new
    if Post.create(:title=>params[:title], :content=>params[:content], :user_id=>session[:user_id])
      flash[:notice] = "Post successfully created"
    else
      flash[:error] = "Failed to create post"
    end
    redirect_to root_path
  end
  
  def show
    # This was used for the ajax "Next" button - but it is not working 100%, especially with the delete action
    # <button id="next_post" type="button" onclick="FIRE.getPost(<%=@post.id-1%>, '<%=session[:login_name]%>')">Next Post</button>
    redirect_to :controller => 'Site', :action => 'index', :post_id => params[:id]
  end
  
  def destroy
    post = Post.find(params[:id])
    if post.user_id==session[:user_id]
      post.destroy
      flash[:notice] = "Post deleted."
    else
      flash[:error] = "Posts can only be deleted by the user who created them."
    end
    redirect_to root_path
  end
end
