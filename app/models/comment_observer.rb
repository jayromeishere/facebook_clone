class CommentObserver < ActiveRecord::Observer
  
  def before_save(comment)
    comment.self_comment = true if comment.commenter_id == comment.post.poster_id  
  end
  
  def after_create(comment)
    if comment.self_comment == false
      comment.notifications.create(
        sender_id: comment.commenter_id,
        recipient_id: comment.post.poster_id
      )
    end
  end
  
end