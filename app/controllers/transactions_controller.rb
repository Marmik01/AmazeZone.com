class TransactionsController < ApplicationController
  before_action :set_transaction, only: %i[ show edit update destroy ]

  # GET /transactions or /transactions.json
  def index
    if current_user
      @transactions = Transaction.where(user_id: current_user.id)
    else
      @transactions = Transaction.all
    end
  end


  # GET /transactions/1 or /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
    # Load the selected product based on the passed product_id parameter
    @product = Product.find(params[:product_id]) if params[:product_id]
    # Get all credit cards associated with the logged-in user
    @credit_cards = current_user.credit_cards
end

  # GET /transactions/1/edit
  def edit
  end

  # POST /transactions or /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    # Generate a random transaction number (10-character alphanumeric)
    @transaction.transaction_number = Array.new(10) { [*"A".."Z", *"0".."9"].sample }.join

    # Find the product being purchased
    @product = Product.find(params[:transaction][:product_id])

    # Link transaction to the current user
    @transaction.user = current_user

    # Deduct the purchased quantity from the product's stock
    if @transaction.quantity > @product.quantity
      flash[:alert] = "Not enough stock available."
      redirect_to new_transaction_path(product_id: @product.id) and return
    end

    @product.quantity -= @transaction.quantity
    @product.save

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: "Transaction was successfully created." }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /transactions/1 or /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: "Transaction was successfully updated." }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1 or /transactions/1.json
  def destroy
    @transaction.destroy!

    respond_to do |format|
      format.html { redirect_to transactions_path, status: :see_other, notice: "Transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
      # params.expect(transaction: [ :transaction_number, :quantity, :total_cost, :user_id, :product_id, :credit_card_id ])
      params.require(:transaction).permit(:quantity, :total_cost, :product_id, :credit_card_id)
    end
end
