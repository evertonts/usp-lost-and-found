class ItemsController < ApplicationController
  before_filter :authenticate_user!, :only => [:create, :update, :destroy]
  before_filter :store_location
  
  
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
  
  def search_lost
    
    search_hash = params[:item]
    
    query = "%#{search_hash[:search]}%"    
    @items = Item.where("lost = ? AND description LIKE ?", true, query)

  end
  
  def search_found
    
    search_hash = params[:item]
    
    query = "%#{search_hash[:search]}%"    
    @items = Item.where("lost = ? AND description LIKE ?", false, query)

  end
  
end
