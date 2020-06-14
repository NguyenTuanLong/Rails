class LineItemsController < ApplicationController
  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    @cart = current_cart
    post = Post.find(params[:post_id])
    if post.quantity >=1
      @line_item = @cart.add_post(post.id)
      post.quantity -=1
      post.save

      respond_to do |format|    
          if @line_item.save
            format.html { redirect_to('/posts', :notice => 'Line item was successfully created') }
            format.js 
            format.json { render :show, status: :created, location: @line_item }
          else
              format.html { render :new }
              format.json { render json: @line_item.errors, status: :unprocessable_entity }
          end
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    before = @line_item.quantity
    post = Post.find(@line_item.post_id)

    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to('/posts', :notice => 'Line item was successfully created') }
        format.json { render :show, status: :ok, location: @line_item }
      else
        format.html { render :edit }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
    after = @line_item.quantity
    
    if post.quantity >= (after-before)
      post.quantity += (before-after)
      post.save
    else
      @line_item.quantity = before
      @line_item.save
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    temp = @line_item.quantity
    post = Post.find(@line_item.post_id)
    post.quantity +=temp
    post.save
    @line_item.destroy
    respond_to do |format|
      format.html { redirect_to posts_path, notice: 'Line item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def line_item_params
      params.require(:line_item).permit(:post_id, :cart_id, :quantity)
    end
end
