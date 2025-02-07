class CreditCardsController < ApplicationController
  before_action :set_credit_card, only: %i[ show edit update destroy ]

  # GET /credit_cards or /credit_cards.json
  def index
    @credit_cards = CreditCard.all
  end

  # GET /credit_cards/1 or /credit_cards/1.json
  def show
  end

  # GET /credit_cards/new
  def new
    @credit_card = CreditCard.new
  end

  # GET /credit_cards/1/edit
  def edit
  end

  # POST /credit_cards or /credit_cards.json
  def create
    @credit_card = CreditCard.new(credit_card_params)

    # Link the new credit card to the currently logged-in user
    @credit_card.user_id = current_user.id

    respond_to do |format|
      if @credit_card.save
        format.html { redirect_to @credit_card, notice: "Credit card was successfully added." }
        format.json { render :show, status: :created, location: @credit_card }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @credit_card.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /credit_cards/1 or /credit_cards/1.json
  def update
    respond_to do |format|
      if @credit_card.update(credit_card_params)
        format.html { redirect_to @credit_card, notice: "Credit card was successfully updated." }
        format.json { render :show, status: :ok, location: @credit_card }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @credit_card.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /credit_cards/1 or /credit_cards/1.json
  def destroy
    @credit_card.destroy!

    respond_to do |format|
      format.html { redirect_to credit_cards_path, status: :see_other, notice: "Credit card was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_credit_card
      @credit_card = CreditCard.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def credit_card_params
      # params.expect(credit_card: [ :name, :card_number, :expiration_date, :cvv, :user_id ])
      params.require(:credit_card).permit(:card_number, :expiration_date, :cvv)
    end
end
