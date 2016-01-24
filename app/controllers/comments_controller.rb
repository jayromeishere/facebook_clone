class CommentsController < ApplicationController
  
  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build
  end
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    redirect_to user_post_path(@post.poster_id, @post.id), notice: "Comment successfully posted!" if @comment.save
  end
  
  private
  
    def comment_params
      params.require(:comment).permit(:commenter_id, :post_id, :text)
    end
    
end
