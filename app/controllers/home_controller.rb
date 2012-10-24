class HomeController < ApplicationController
  before_filter :store_location
  
  def index
    @users = User.all
    @item = Item.new
    @items_lost = Item.where(:lost => true, :returned => false).order("created_at desc").limit(10).reverse
    @items_found = Item.where(:lost => false, :returned => false).order("created_at desc").limit(10).reverse
    @tags = Item.tag_counts_on(:tags) | ActsAsTaggableOn::Tag.all

  end
end
