class UsersController < ApplicationController
  before_filter :authenticate_user! 
  
  load_and_authorize_resource
  
  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items
    @messages = current_user.all_messages
    @sent_messages = current_user.sent_messages
    @received_messages = current_user.received_messages
  end

end
