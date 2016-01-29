module ApplicationHelper
  def current_users_like_of(source)
    like = Like.where("liker_id = ? AND likeable_id = ?", current_user.id, source.id).last
       # usually doesn't return a single record, but we know this user's like should be unique among the post's likes 
    like
  end
end
