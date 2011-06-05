class PostController < ApplicationController
  def new
    if Post.create(:title=>params[:title], :content=>params[:content], :user_id=>session[:user_id])
      flash[:notice] = "Post successfully created"
    else
      flash[:error] = "Failed to create post"
    end
    redirect_to root_path
  end
  
  def show
    post = Post.find(params[:id])
    render :text => [post, post.user].to_json
  end
end
