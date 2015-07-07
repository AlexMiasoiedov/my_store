class ItemsController < ApplicationController

  before_filter :find_item, only: [:show, :edit, :update, :destroy, :upvote]
  #before_filter :check_if_admin, only: [:edit, :update, :new, :create, :destroy]

  def index
    @item = Item.all
  end

  def expensive
    @item = Item.where("price > 1000")
    render "index"
  end

  # /items/1 get
  def show
    unless @item
      render_404# text: "Page not found", status: 404
    end
  end

  # /items/new get
  def new
    @item = Item.new
  end

  # /items/:id/edit get
  def edit
  end

  # /items post
  def create
    @item = Item.create(item_params)
    if @item.errors.empty?
      flash[:success] = "File successfully updated!"
      redirect_to item_path(@item) # items/1?:id
    else
      flash[:error] = "Mistakes in tour form!"
      render "new"
    end
  end

  # /items/1 put
  def update
    @item.update_attributes(item_params)
    if @item.errors.empty?
      redirect_to item_path(@item) # items/:id
    else
      render "edit"
    end
  end

  # /items/1 delete
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    render json: { success: true }
    ItemsMailer.item_destroyed(@item).deliver
  end

  def upvote
    @item.increment!(:votes_count)
    redirect_to action: :index
  end

  private

  def find_item
    @item = Item.where(id: params[:id]).first
    render_404 unless @item
  end

  def item_params
    params.require(:item).permit!
  end

end
