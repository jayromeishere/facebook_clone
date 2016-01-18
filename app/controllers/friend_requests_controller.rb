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
    accept_friend_request
    redirect_to @requested_user, notice: "Friend Request Accepted!" 
  end
  
  def destroy
    @user_1 = User.find(params[:user_id])
    @user_2 = User.find(params[:id])
    @friend_request = friend_request_to_destroy
    @friend_request[0].destroy
    # friend_request_to_destroy should return one element array (relation) 
    redirect_to user_path(current_user), notice: "You are no longer friends with #{@user_2.name}."
  end
  
  private
  
    def accept_friend_request
      @friend_request.accepted = true
      @friend_request.save
    end
    
    def friend_request_to_destroy
      active_request = @user_1.active_friend_requests.accepted.where("requested_id = ?", @user_2.id)
      passive_request = @user_1.passive_friend_requests.accepted.where("requester_id = ?", @user_2.id)
      active_request == User.none ? passive_request : active_request
    end

    
end
