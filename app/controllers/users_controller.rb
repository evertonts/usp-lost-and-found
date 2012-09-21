class UsersController < ApplicationController
  before_filter :authenticate_user! 

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items
    @messages = current_user.all_messages
  end

end
