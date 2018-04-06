require 'rails_helper'

RSpec.describe ListsController, type: :controller do
  let(:new_list) { create(:list) }

  describe "#index" do
    it "responds successfully" do
      get :index
      expect(response).to be_success
    end

    it "returns a 200 response" do
      get :index
      expect(response).to have_http_status "200"
    end
  end

  describe "#create" do
    it "adds as list" do
      list_params = attributes_for(:list)
      expect {
        post :create, params: { list: list_params }
      }.to change(List.all, :count).by(1)
    end
  end

  describe "#update" do
    it "updates a list" do
      list_params = attributes_for(:list, title: "Some new title")
      post :update, params: { id: new_list.id, list: list_params  }
      expect(new_list.reload.title).to eq "Some new title"
    end
  end

  describe "#delete" do
    it "deletes a list" do
      some_list = create(:list)
      expect {
        delete :destroy, params: { id: some_list.id }
      }.to change(List.all, :count).by(-1)
    end
  end
end
