require 'rails_helper'

RSpec.describe List, type: :model do
  
  it "has a valid factory" do
    expect(FactoryBot.build(:list)).to be_valid
  end

  it "is invalid without a title" do
    list = FactoryBot.build(:list, title: nil)
    list.valid?
    expect(list.errors[:title]).to include("can't be blank")
  end

  it "is invalid with a duplicate title" do
    FactoryBot.create(:list, title: "some title")
    list = FactoryBot.build(:list, title: "some title")
    list.valid?
    expect(list.errors[:title]).to include("has already been taken")
  end
end
