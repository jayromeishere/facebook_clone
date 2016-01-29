class LikesController < ApplicationController
  def create
    @source = params[:comment_id] ? Comment.find_by(id: params[:comment_id]) : Post.find_by(id: params[:post_id]) 
    @like = @source.likes.build(liker_id: current_user.id,
                                recipient_id: if @source.class.name == "Comment"
                                                @source.commenter_id
                                              elsif @source.class.name == "Post" 
                                                @source.poster_id
                                              end,
                                likeable_type: @source.class.name)
    redirect_to feed_path, notice: "#{@source.class.name} liked!" if @like.save
  end
  
  def destroy
    @source = params[:comment_id] ? Comment.find_by(id: params[:comment_id]) : Post.find_by(id: params[:post_id])
    @like = @source.likes.find(params[:id])
    redirect_to feed_path, notice: "#{@source.class.name} unliked." if @like.destroy
  end
  
  private
    
    
end
