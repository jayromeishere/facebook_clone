class StaticPagesController < ApplicationController
  
  def welcome
    
  end
  
  def feed
    friend_ids = []
    friends(current_user).each { |f| friend_ids << f.id } 
    @feed_posts = Post.where("poster_id IN (?)", friend_ids)
                      .order(created_at: :desc)
  end
  
  def notifications
    
  end
  
  private
  
    def friends(user)
      user.friends_from_active_requests |
      user.friends_from_passive_requests
    end
  
end
