require 'rails_helper'

RSpec.describe List, type: :model do
  it "valid with valid attributes" do
    expect(List.new(title: 'not blank title')).to be_valid
  end

  it "not valid without a title" do
    list = List.new(title: nil)
    expect(list).to_not be_valid
  end
end
