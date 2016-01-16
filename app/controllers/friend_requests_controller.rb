class FriendRequestsController < ApplicationController
  include ActiveModel::Dirty
  
  def create
    @requested_user = User.find(params[:user_id])
    @friend_request = @requested_user.passive_friend_requests.build(requester_id: current_user.id)
    if @friend_request.save
      redirect_to @requested_user, notice: "Friend Request Sent!"
    else
      redirect_to @requested_user, notice: "Friend Request not sent."
    end
  end
  
  def update
    @requested_user = User.find(params[:user_id])
    @requester = User.find(params[:id])
    @friend_request = @requested_user.passive_friend_requests.pending.where("requester_id = ?", @requester.id).last
    toggle_friend_request
    if @friend_request.accepted_changed?
      redirect_to @requested_user, notice: "Friend Request Accepted!"
    else
      redirect_to @requested_user, notice: "Friend Request not accepted."
    end
  end
  
  private
  
    def toggle_friend_request
      @friend_request.accepted == false ? 
        @friend_request.accepted = true : 
        @friend_request.accepted = false
      @friend_request.save
    end

    
end
