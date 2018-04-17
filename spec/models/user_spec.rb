require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    expect(build(:user)).to be_valid
  end

  it "has a factory witch create different emails" do
    first_user = create(:user)
    second_user = create(:user)
    expect(second_user).to be_valid
  end
end
