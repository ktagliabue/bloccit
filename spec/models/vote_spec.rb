require 'rails_helper'

RSpec.describe Vote, :type => :model do
  it "Vote validations value validation only allows -1 or 1 as values" do
    expect(Vote.new(value: 1).valid?).to eq(true)
    expect(Vote.new(value: -1).valid?).to eq(true)
    expect(Vote.new(value: -20).valid?).to eq(false)
  end
end
