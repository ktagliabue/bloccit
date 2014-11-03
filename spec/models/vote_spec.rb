require 'rails_helper'

RSpec.describe Vote, :type => :model do
  # describe '#votes' do
  it "Vote validations value validation only allows -1 or 1 as values" do
   # expect(@posts).to eq(1||-1)
    expect(bad_v.valid?).to eq(false)
  end
     # end
end
