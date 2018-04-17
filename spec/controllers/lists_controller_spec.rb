require 'rails_helper'

RSpec.describe ListsController, type: :controller, js: true do
  let(:list) { create(:list) }

  before do
    sign_in list.user
  end

  describe "#index" do
    it "responds successfully" do
      get :index, xhr: true
      expect(response).to be_success
    end

    it "returns a 200 response" do
      get :index, xhr: true
      expect(response).to have_http_status "200"
    end
  end

  describe "#create" do
    it "adds as list" do
      list_params = attributes_for(:list)
      expect {
        post :create, params: { list: list_params }, xhr: true
      }.to change(List.all, :count).by(1)
    end
  end

  describe "#update" do
    it "updates a list" do
      list_params = attributes_for(:list, title: "Some new title")
      post :update, params: { id: list.id, list: list_params  }, xhr: true
      expect(list.reload.title).to eq "Some new title"
    end
  end

  describe "#delete" do
    it "deletes a list" do
      some_list = create(:list, user: list.user)
      
      expect {
        delete :destroy, params: { id: some_list.id }, xhr: true
      }.to change(List.all, :count).by(-1)
    end
  end
end
