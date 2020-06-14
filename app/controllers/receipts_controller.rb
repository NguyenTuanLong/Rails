class ReceiptsController < ApplicationController
  before_action :set_receipt, only: [:show, :edit, :update, :destroy]

  # GET /receipts
  # GET /receipts.json
  def index
    @receipts = current_user.receipts
    @user = current_user
  end

  # GET /receipts/1
  # GET /receipts/1.json
  def show
    @receipt = Receipt.find_by(id: params[:id])
    unless current_user == @receipt.user
      redirect_to receipts_path
    end
  end

  # GET /receipts/new
  def new
    @receipt = Receipt.new
  end

  # GET /receipts/1/edit
  def edit
  end

  # POST /receipts
  # POST /receipts.json
  def create
    @receipt = Receipt.new
    @receipt.user = current_user
    @receipt.save!
    current_cart.line_items.each do |a|
      current_record = add_record_to_receipt(a.post.title, a)
      current_record.receipt = @receipt
      current_record.save!
    end
    @receipt.save!
    current_cart.destroy
    redirect_to receipts_url
  end

  # PATCH/PUT /receipts/1
  # PATCH/PUT /receipts/1.json
  def update
    respond_to do |format|
      if @receipt.update(receipt_params)
        format.html { redirect_to @receipt, notice: 'Receipt was successfully updated.' }
        format.json { render :show, status: :ok, location: @receipt }
      else
        format.html { render :edit }
        format.json { render json: @receipt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /receipts/1
  # DELETE /receipts/1.json
  def destroy
    @receipt.destroy
    respond_to do |format|
      format.html { redirect_to receipts_url, notice: 'Receipt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_receipt
      @receipt = Receipt.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def receipt_params
      params.fetch(:receipt, {})
    end

    def add_record_to_receipt(title,a)
        current_record = Record.new
        current_record.title = a.post.title
        current_record.body = a.post.body
        current_record.user_id = current_user
        current_record.price = a.post.price
        current_record.cost = a.post.cost
        current_record.quantity = a.quantity
        if a.post.image.attached?
          current_record.image = a.post.image.blob
        end
      return current_record
    end
end
