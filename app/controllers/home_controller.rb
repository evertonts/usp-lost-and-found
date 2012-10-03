class HomeController < ApplicationController
  def index
    @users = User.all
    @item = Item.new
    @items_lost = Item.where(:lost => true).order("created_at desc").limit(10).reverse
    @items_found = Item.where(:lost => false).order("created_at desc").limit(10).reverse
    @tags = Item.tag_counts_on(:tags)
    
    ActsAsTaggableOn::Tag.all.each do |tag|
      unless @tags.include? tag
        @tags << tag
      end
    end
  end
end
