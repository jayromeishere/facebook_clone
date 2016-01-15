class FriendRequestsController < ApplicationController
  
  def create
    @user = User.find(params[:user_id])
    @friend_request = @user.passive_friend_requests.build(requester_id: current_user.id)
    if @friend_request.save
      redirect_to @user, notice: "Friend Request Sent!"
    else
      redirect_to @user, notice: "Friend Request not sent."
    end
  end
  

    
end
