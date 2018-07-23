require 'rails_helper'

RSpec.describe FilesController, type: :controller, js: true do
  let(:user) { create(:user) }
  let(:some_list) { create(:list, user: user) }

  before do
    sign_in user
  end

  describe "#create" do
    it "creates new file" do
      file_params = attributes_for(:file)
      expect {
        post :create, params: { list_id: some_list.id, file: file_params }, xhr: true
      }.to change(some_list.files, :count).by(1)
    end
  end

  describe "#delete" do
    it "deletes a file" do
      file = create(:file, list: some_list)
      expect {
        delete :destroy, params: { list_id: some_list.id, id: file.id }, xhr: true
      }.to change(some_list.files, :count).by(-1)
    end
  end

  describe "#update" do
    it "updates a file" do
      file = create(:file, list: some_list)
      file_params = attributes_for(:file, content: "Some new content")
      post :update, params: { list_id: some_list.id, id: file.id, file: file_params }, xhr: true
      expect(file.reload.content).to eq "Some new content"
    end
  end
end
