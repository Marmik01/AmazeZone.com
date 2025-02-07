require "application_system_test_case"

class TransactionsTest < ApplicationSystemTestCase
  setup do
    @transaction = transactions(:one)
  end

  test "visiting the index" do
    visit transactions_url
    assert_selector "h1", text: "Transactions"
  end

  test "should create transaction" do
    visit transactions_url
    click_on "New transaction"

    fill_in "Credit card", with: @transaction.credit_card_id
    fill_in "Product", with: @transaction.product_id
    fill_in "Quantity", with: @transaction.quantity
    fill_in "Total cost", with: @transaction.total_cost
    fill_in "Transaction number", with: @transaction.transaction_number
    fill_in "User", with: @transaction.user_id
    click_on "Create Transaction"

    assert_text "Transaction was successfully created"
    click_on "Back"
  end

  test "should update Transaction" do
    visit transaction_url(@transaction)
    click_on "Edit this transaction", match: :first

    fill_in "Credit card", with: @transaction.credit_card_id
    fill_in "Product", with: @transaction.product_id
    fill_in "Quantity", with: @transaction.quantity
    fill_in "Total cost", with: @transaction.total_cost
    fill_in "Transaction number", with: @transaction.transaction_number
    fill_in "User", with: @transaction.user_id
    click_on "Update Transaction"

    assert_text "Transaction was successfully updated"
    click_on "Back"
  end

  test "should destroy Transaction" do
    visit transaction_url(@transaction)
    click_on "Destroy this transaction", match: :first

    assert_text "Transaction was successfully destroyed"
  end
end
