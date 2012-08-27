class HomeController < ApplicationController
  def index
    @users = User.all
    @item = Item.new
  end
end
