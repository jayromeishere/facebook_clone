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
    @friend_request = @requested_user.passive_friend_requests.where("requester_id = ?", @requester.id).last
    if @friend_request.accepted == false
      accept_friend_request
      redirect_to @requested_user, notice: "Friend Request Accepted!" 
    else
      unfriend
      redirect_to @requested_user, notice: "You are no longer friends with #{requester.name}."
    end  
  end
  
  private
  
    def accept_friend_request
      @friend_request.accepted = true
      @friend_request.save
    end
    
    def unfriend
      @friend_request.accepted = false
      @friend_request.save
    end

    
end
