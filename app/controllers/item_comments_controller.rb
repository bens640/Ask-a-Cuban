class ItemCommentsController < ApplicationController
  before_action :set_item
  skip_before_filter  :verify_authenticity_token, if: :json_request?

  def index
    respond_to do |format|
      format.html {@comments = @item.comments}
      format.json  {
        render json: @item.as_json(
                   include: :comments)
      }
    end
  end

  def create
    @comment = current_user.item_comments.build(comment_params)
    respond_to do |format|
    if @comment.save
      format.html {redirect_back_or_to item_path(@item), notice: "Success."}
      format.json {head :ok}
    else
      redirect_back_or_to item_path(@item), notice: @comment.errors.full_messages.join(". ")
    end
    end
  end

  def update
  end

  def destroy
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
    return redirect_back_or_to root_path, notice: 'could not find item' unless @item
  end

  def comment_params
    params.require(:item_comment).permit(:content).merge({item_id: params[:item_id]})
  end
  protected
  def json_request?

    request.format.to_s.include? 'json'

  end
end
