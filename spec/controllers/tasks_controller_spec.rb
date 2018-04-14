require 'rails_helper'

RSpec.describe TasksController, type: :controller, js: true do
  let(:some_list) { create(:list) }

  describe "#create" do
    it "creates new task" do
      task_params = attributes_for(:task)
      expect {
        post :create, params: { list_id: some_list.id, task: task_params }, xhr: true
      }.to change(some_list.tasks, :count).by(1)
    end
  end

  describe "#delete" do
    it "deletes a task" do
      task = create(:task, list: some_list)
      expect {
        delete :destroy, params: { list_id: some_list.id, id: task.id }, xhr: true
      }.to change(some_list.tasks, :count).by(-1)
    end
  end

  describe "#update" do
    it "updates a task" do
      task = create(:task, list: some_list)
      task_params = attributes_for(:task, content: "Some new content")
      post :update, params: { list_id: some_list.id, id: task.id, task: task_params }, xhr: true
      expect(task.reload.content).to eq "Some new content"
    end
  end
end
