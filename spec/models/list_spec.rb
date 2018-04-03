require 'rails_helper'

RSpec.describe List, type: :model do
  subject{ described_class.new(title: "some title") }

  it "valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "not valid without a title" do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it "not valid with not unique title" do
    subject.save
    new_list = List.create(title: "some title")
    expect(new_list.errors[:title]).to include("has already been taken")
  end
end
