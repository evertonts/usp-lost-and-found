class ItemsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new_lost, :new_found, :create, :update, :destroy]
  before_filter :store_location
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  load_and_authorize_resource
  
  
  def new_item
    @item = Item.new
    @item.assets.build
  end
  
  # GET /items
  def index
    @items = Item.all
  end

  def new_lost
    new_item    
    @item.lost = true
  end
  
  def new_found
    new_item
    @item.lost = false
  end
  
  # GET /items/1
  def show
    @item = Item.find(params[:id])
    @message = Message.new
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
    @item.assets.build
  end

  # POST /items
  def create
    @item = Item.new(params[:item])
    @item.user = current_user

    if @item.save
      redirect_to @item, notice: 'Item cadastrado com sucesso.'
    else
      render action: @item.lost? ? "new_lost" : "new_found"
    end
  end

  # PUT /items/1
  def update
    @item = Item.find(params[:id])
    
    if @item.update_attributes(params[:item])
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /items/1
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_url
  end
  
  def search
    
    if params[:tag]
      @items = Item.tagged_with(params[:tag])
    else
      search_hash = params[:item]
    
      lost = search_hash[:lost] == "true" ? true : false
            
      query = "%#{search_hash[:search]}%"    
      @items = #Item.where("lost = ? AND description LIKE ?", lost, query) \
       Item.where("lost = ? AND title LIKE ?", lost, query) \
      | Item.tagged_with_like(query)
      
      @items = @items.reject {|item| item.returned? }
    end

  end
  
  def recover 
    item = Item.find(params[:id])
    item.returned = true
    item.save!
    redirect_to :back
  end
  
end
