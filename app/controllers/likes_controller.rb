class LikesController < ApplicationController
  def create
    @source = params[:comment_id] ? Comment.find_by(id: params[:comment_id]) : Post.find_by(id: params[:post_id]) 
    @like = @source.likes.build(liker_id: current_user.id, likeable_type: @source.class.name)
    redirect_to feed_path, notice: "#{@source.class.name} liked!" if @like.save
  end
  
  def destroy
    @source = params[:comment_id] ? Comment.find_by(id: params[:comment_id]) : Post.find_by(id: params[:post_id])
    @like = @post.likes.find_by(id: params[:id])
    redirect_to feed_path, notice: "#{@source.class.name} unliked." if @like.destroy
  end
  
  private
    
    
end
