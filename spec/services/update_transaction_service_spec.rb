require 'rails_helper'

RSpec.describe UpdateTransactionService, type: :service do
  subject(:call) { described_class.new(attributes: attributes, transaction: transaction).call }

  let!(:transaction) do
    FactoryBot.create(:transaction, user: current_user, description: "my description", amount: "12000", classification: "income")
  end

  let!(:current_user) { FactoryBot.create(:user) }

  context "success" do
    let(:attributes) do
      { description: "updated transaction", amount: "12", classification: "expense" }
    end

    it "outcome to be success" do
      expect(call).to be_success
    end

    it "outcome include upadate attribute" do
      expect(call.value.description).to eq("updated transaction")
    end
  end

  context "faliure" do
    let(:attributes) do
      { description: "updated transaction", amount: "12", classification: "corege" }
    end

    it "outcome to classification error" do
      expect(call.error).to eq({ :errors => ["Classification is not included in the list"]})
    end
  end
end