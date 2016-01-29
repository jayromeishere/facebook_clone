class LikeObserver < ActiveRecord::Observer
  
  def before_save(like)
    like.self_like = true if like.liker_id == like.recipient_id
  end
  
  def after_create(like)
    if like.self_like == false
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
end