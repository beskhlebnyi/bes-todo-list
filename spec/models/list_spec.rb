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
end
