class ItemsController < ApplicationController
  before_action :require_login, only: [:new, :create, :edit, :update, :toggle]
  before_action :set_item, only: [:show]
  before_action :set_user_item, only: [:edit, :update, :toggle]
  skip_before_filter  :verify_authenticity_token, if: :json_request?


  def index
    order = params[:newest] ? {created_at: :desc} : {rank: :desc}

    @items = Item.order(order).includes(:user)
    @votes = @items.includes(:votes).each_with_object({}) do |item, object|
      object[item.id] = item.votes.map(&:user_id)
    @pag_items = @items.paginate(:page => params[:page], :per_page => 10)
    end
    respond_to do |format|
      format.html
      format.json { render json: @items}
      format.apre { render json: @pag_items}
    end

  end



  def show
    @changed_items= []
    @comments = @item.comments.includes(:user).order(created_at: :asc)
    @pag_comments = @comments.paginate(:page => params[:page], :per_page => 10)
    @item.check_comments @changed_items, @comments
    respond_to do |format|
      format.html
      format.json { render json: @comments}
      format.apre { render json: @changed_items}
    end

  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = current_user.items.build(item_params)

    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render :new
    end
  end

  def update
    if @item.update(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render :edit
    end
  end

  def toggle
    @item.update(:disabled, @item.disabled?)
    message = item.disabled? ? 'disabled' : 'enabled'
    redirect_to @item, notice: "Item #{message}."
  end

  private
  def set_item
    @item = Item.includes(:votes).find(params[:id])
    @votes = [@item].each_with_object({}) do |item, object|
      object[item.id] = item.votes.map(&:user_id)
    end
  end

  def set_user_item
    @item = current_user.items.where(id: params[:id]).first
    unless @item
      redirect_to :back, notice: 'Unauthorized'
      return
    end
  end

  def item_params
    params.require(:item).permit(:title, :url, :content)
  end

  protected
  def json_request?
    request.format.json?

  end

end
