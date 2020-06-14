class RecordsController < ApplicationController
  before_action :set_record, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /records
  # GET /records.json
  def index
    @records = Record.all
    @user = current_user
  end

  # GET /records/1
  # GET /records/1.json
  def show
    @record = Record.find_by(id: params[:id])
  end

  # GET /records/new
  def new
    @record = Record.new
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  # POST /records.json
  def create
    current_cart.line_items.each do |a|
      @record = add_record(a.post.title, a)
      @record.save
    end
    current_cart.destroy
    redirect_to records_url
  end

  # PATCH/PUT /records/1
  # PATCH/PUT /records/1.json
  def update
    respond_to do |format|
      if @record.update(record_params)
        format.html { redirect_to @record, notice: 'Record was successfully updated.' }
        format.json { render :show, status: :ok, location: @record }
      else
        format.html { render :edit }
        format.json { render json: @record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /records/1
  # DELETE /records/1.json
  def destroy
    @record.destroy
    respond_to do |format|
      format.html { redirect_to receipts_url, notice: 'Record was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = Record.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def record_params
      params.require(:record).permit(:title, :body, :user_id, :price, :cost, :quantity)
    end

    def add_record(title,a)
      current_record = Record.find_by(title: title)
      if current_record
          current_record.quantity += 1
      else
          current_record = Record.new
          current_record.title = a.post.title
          current_record.user = current_user
          current_record.body = a.post.body
          current_record.price = a.post.price
          current_record.cost = a.post.cost
          current_record.quantity = a.quantity
          if a.post.image.attached?
            current_record.image = a.post.image.blob
          end
      end
      return current_record
  end
end
