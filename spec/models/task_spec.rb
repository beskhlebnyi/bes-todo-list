require 'rails_helper'

RSpec.describe Document, type: :model do
  it "has a valid factory" do
    expect(build(:document, :with_list)).to be_valid
  end

  it "is invalid without content" do
    document = build(:document, :with_list, content: nil)
    document.valid?
    expect(document.errors[:content]).to include("can't be blank")
  end

end
