require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @list = List.create( title: "Some title" ) 
  end

  it "is valid with list" do
    task = Task.new(
      content: "Some content",
      status: false,
      important: true,
      list: @list
    )
    expect(task).to be_valid
  end

  it "is invalid without list" do
    task = Task.new(
      content: "Some content",
      status: false,
      important: true,
      list: nil
    )
    expect(task).not_to be_valid
  end

  it "is invalid without content" do
    task = Task.new(
      content: nil,
      status: false,
      important: true,
      list: @list
    )
    expect(task).not_to be_valid
  end

end
