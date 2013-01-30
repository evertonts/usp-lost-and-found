require 'ItemRecomender'
class ItemsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new_lost, :new_found, :create, :update, :destroy]
  before_filter :store_location
  
  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag'

  load_and_authorize_resource
  
  def new_item
    @item = Item.new
    @item.assets.build
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
        
    if @item.user == current_user
      lost = !@item.lost
      @same_user = true
    else
      lost = @item.lost
      @same_user = false
    end
      
    @recomendeds = ItemRecomender.similar(@item, 5, lost)
    
  end

  def edit
    @item = Item.find(params[:id])
    @item.assets.build
  end

  def create
    @item = Item.new(params[:item])
    @item.user = current_user
    @item.returned = false

    if @item.save
      redirect_to @item, notice: 'Item cadastrado com sucesso.'
    else
      @item.assets.build
      render action: @item.lost? ? "new_lost" : "new_found"
    end
  end

  # PUT /items/1
  def update
    @item = Item.find(params[:id])
    
    if @item.update_attributes(params[:item])
      redirect_to @item, notice: 'Item atualizado com sucesso'
    else
      @item.assets.build
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
    
    aux = params[:item]
    lost = (aux[:lost] == "true") ? true : false
    termo = aux[:search] 
    
    if termo.blank?   
      @items = Item.where(:lost => lost, :returned => false).sort! {|a, b| b.created_at <=> a.created_at}
    else
      @search = Item.search do
      
        with(:returned, false)      
        with(:lost, lost)
      
        keywords termo, :minimum_match => 1
      end
      @items = @search.results
    end
    
    
    @lost = lost

  end
  
  def tag
    if params[:tag]
      @items = Item.tagged_with(params[:tag]).order('created_at DESC')
    end
  end

  def recover 
    item = Item.find(params[:id])
    item.returned = true
    item.save!
    
    if item.lost?
      returned = "recuperado"
    else
      returned = "devolvido"
    end
    
    redirect_to :back, :notice => "Item marcado como #{returned}"
  end
  
  def recovered
    @lost = params[:lost] == 'true' ? true : false
    @items = Item.where(:returned => true, :lost => @lost)
  end
end
