require 'rails_helper'

RSpec.describe DocumentsController, type: :controller, js: true do
  let(:user) { create(:user) }
  let(:some_list) { create(:list, user: user) }

  before do
    sign_in user
  end

  describe "#create" do
    it "creates new document" do
      document_params = attributes_for(:document)
      expect {
        post :create, params: { list_id: some_list.id, document: document_params }, xhr: true
      }.to change(some_list.documents, :count).by(1)
    end
  end

  describe "#delete" do
    it "deletes a document" do
      document = create(:document, list: some_list)
      expect {
        delete :destroy, params: { list_id: some_list.id, id: document.id }, xhr: true
      }.to change(some_list.documents, :count).by(-1)
    end
  end

  describe "#update" do
    it "updates a document" do
      document = create(:document, list: some_list)
      document_params = attributes_for(:document, content: "Some new content")
      post :update, params: { list_id: some_list.id, id: document.id, document: document_params }, xhr: true
      expect(document.reload.content).to eq "Some new content"
    end
  end
end
