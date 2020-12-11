require 'rails_helper'

RSpec.describe TransactionsController, type: :controller do
  let!(:current_user) { FactoryBot.create(:user) }
  let(:response_body) { JSON.parse(response.body) }

  describe "create" do
    before { login(current_user) }

    context " success" do
      let(:valid_attributes) do
      { description: "transaction description", amount: "12", classification: "expense", user_id: current_user.id}
      end

      it "success to create transaction" do
        expect do
          post :create, params: { transaction: valid_attributes }
        end.to change(Transaction, :count).by(1)
      end

      it 'renders new account' do
        expect(response.status).to eq(200)
      end
    end

    context "failure" do
      before do
        login(current_user)
        post :create, params: { transaction: invalid_attributes }
      end

      let(:invalid_attributes) do
        { description: nil, amount: "12", classification: "income", user_id: current_user.id }
      end

      it "returns response status as 422(unprocessable_entity)" do
        expect(response.status).to eq(422)
      end

      it 'renders errors' do
        expect(response_body["errors"]).to include("Description can't be blank")
      end
    end
  end

  describe "index" do
    let!(:transaction) do
      FactoryBot.create(:transaction, user: current_user, description: "my description", amount: "12000", classification: "income")
    end

    context "autorized user success" do
      before do
        login(current_user)
        get :index
      end

      it "render JSON" do
        expect(response_body).to include({
          "description"=> "my description",
          "amount"=> 12000,
          "classification"=> "income",
          "id"=> transaction.id
        })
      end

      it "response status 200" do
        expect(response).to be_ok
      end
    end

    context "unauthorized user failiure" do
      before do
        get :index
      end

      it "response status 403" do
        expect(response.status).to eq(401)
      end
    end
  end

  describe "update" do
    let!(:transaction) do
      FactoryBot.create(:transaction, user: current_user, description: "my description", amount: "12000", classification: "income")
    end

    before do
      login(current_user)
      put :update, params: { transaction: attributes, id: transaction.id }
    end

    context "success" do
      let(:attributes) do
        { description: "new updated description", amount: "12", classification: "expense" }
      end

      it "response status as  200" do
        expect(response.status).to  eq(200)
      end

      it "render success" do
        expect(response_body).to  eq({ "success" => true })
      end
    end

    context "faliure" do
      let(:attributes) do
        { description: "faiure" , amount: nil, classification: "expense" }
      end

      it "response  status (unprocessable_entity)" do
        expect(response.status).to eq(422)
      end

      it "render faliure" do
        expect(response_body["errors"]).to eq({"errors" => ["Amount can't be blank"]})
      end
    end
  end

  describe "destory" do
    let!(:transaction) do
      FactoryBot.create(:transaction, user: current_user, description: "my description", amount: "12000", classification: "income")
    end

    context "success" do

      before do
        login(current_user)
        delete :destroy, params: { id: transaction.id }
      end

      it "deletes transaction" do
        expect(response.status).to eq(200)
      end

      it "render success " do
        expect(response_body).to eq({ "success" => true})
      end
    end

    context "failure" do
      let!(:not_current_user) { FactoryBot.create(:user, first_name: "whiteson", last_name: "vasar", email: "whiteson@mail.com", password: "1234567890", password_confirmation: "1234567890") }
      let!(:transaction) do
        FactoryBot.create(:transaction, user: current_user, description: "my description", amount: "12000", classification: "income")
      end

      before do
        login(not_current_user)
        delete :destroy, params: { id: transaction.id }
      end

      it "returns failure to not_current_user" do
        expect(response.status).to eq(401)
      end
    end
  end


  describe "show" do
    let!(:transaction) do
      FactoryBot.create(:transaction, user: current_user, description: "show description", amount: "12000", classification: "income")
    end

    context "success" do
      before do
        login(current_user)
        get :show, params: { id: transaction.id }
      end

      it "render success status" do
        expect(response.status).to eq(200)
      end

      it "render transaction " do
        expect(response_body).to include("description" => "show description")
      end
    end

    context "failure" do
      before do
        get :show, params: { id: transaction.id }
      end

      it "unautorized access" do
        expect(response.status).to eq(401)
      end
    end
  end
end

