class PostsController < ApplicationController
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    redirect_to feed_path, notice: "Post successfully created!" if @post.save
  end
  
  def update
    
  end
  
  def destroy
    
  end
  
  private
  
    def post_params
      params.require(:post).permit(:poster_id, :text)
    end
    
end
