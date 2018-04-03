require 'rails_helper'

RSpec.describe Task, type: :model do
  before do
    @list = List.create( title: "Some title" ) 
  end

  subject{ described_class.new(
    content: "Some content",
    status: false,
    important: true,
    list: @list
  )}

  it "is valid with list" do
    expect(subject).to be_valid
  end

  it "is invalid without list" do
    subject.list = nil
    expect(subject).not_to be_valid
  end

  it "is invalid without content" do
    subject.content = nil
    expect(subject).not_to be_valid
  end 
end
