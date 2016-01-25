class StaticPagesController < ApplicationController
  
  def welcome
    
  end
  
  def feed
    # get posts from current user AND his friends
    feed_post_ids = [  ]
    friends(current_user).each { |f| feed_post_ids << f.id } 
    @feed_posts = Post.where("poster_id IN (?) OR poster_id = ?", feed_post_ids, current_user.id)
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
