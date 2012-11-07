class HomeController < ApplicationController
  before_filter :store_location
  
  def index
    @users = User.all
    @item = Item.new
    @items_lost = Item.where(:lost => true, :returned => false).order("created_at DESC").limit(10)
    @items_found = Item.where(:lost => false, :returned => false).order("created_at DESC").limit(10)
    @tags = Item.tag_counts_on(:tags).order("name")

  end
end
