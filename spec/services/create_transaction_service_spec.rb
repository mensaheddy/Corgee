require 'rails_helper'

RSpec.describe CreateTransactionService, type: :service do
  describe "call" do
    subject(:call) { described_class.new(attributes: attributes).call }

    let!(:user) { FactoryBot.create(:user) }

    context "valid inputs" do
      let(:attributes) do
        { description: "transaction description", amount: "12", classification: "expense", user_id: user.id}
      end

      it "outcome to be success" do
        expect(call).to be_success
      end

      it "create a Transaction" do
        expect { call }.to change(Transaction, :count).by(1)
      end
    end

    context "invalid inputs" do
      let(:attributes) do
        { description: "transaction description" , amount: "12", classification: "coregee", user_id: user.id}
      end

      it "outcome to be failure" do
        expect(call).to be_failure
      end
    end
  end
end