class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @users = User.all
  end
  
  def show
    @user = User.find(params[:id])
    @profile_posts = @user.posts.order(created_at: :desc)
  end
  
  private
  

  
end
