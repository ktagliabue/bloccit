require 'rails_helper'

RSpec.describe Vote, :type => :model do
  it "Vote validations value validation only allows -1 or 1 as values" do
    expect(bad_v.valid?).to eq(true)
  end
end
