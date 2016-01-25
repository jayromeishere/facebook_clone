class LikeObserver < ActiveRecord::Observer
  def after_create(like)
    like.notifications.create(
      sender_id: like.liker_id,
      recipient_id: if like.likeable_type == "Post"
                      like.likeable.poster_id
                    elsif like.likeable_type == "Comment"
                      like.likeable.commenter_id 
                    end
    )
  end
end