class CommentObserver < ActiveRecord::Observer
  def after_create(comment)
    comment.notifications.create(
      sender_id: comment.commenter_id,
      recipient_id: comment.post.poster_id
    )
  end
end