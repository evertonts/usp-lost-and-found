class ItemsController < ApplicationController
  
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
  end

  # GET /items/1/edit
  def edit
    @item = Item.find(params[:id])
  end

  # POST /items
  def create
    @item = Item.new(params[:item])

    if @item.save
      redirect_to @item, notice: 'Item cadastrado com sucesso.'
    else
      render action: "new"
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
  end
  
  def search
    
    
    render :search_lost
  end
  
end
