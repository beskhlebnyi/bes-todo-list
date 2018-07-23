require 'rails_helper'

RSpec.describe Document, type: :model do
  it "has a valid factory" do
    expect(build(:file, :with_list)).to be_valid
  end

  it "is invalid without content" do
    file = build(:file, :with_list, content: nil)
    file.valid?
    expect(file.errors[:content]).to include("can't be blank")
  end

end
