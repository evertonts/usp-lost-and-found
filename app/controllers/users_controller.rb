class UsersController < ApplicationController
  before_filter :authenticate_user! 

  def index
    authorize! :index, @user, :message => 'Not authorized as an administrator.'
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @items = @user.items
    @message = Message.new
    @messages = current_user.sent_messages
    @messages << current_user.received_messages
  end

end
