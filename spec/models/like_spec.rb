require 'rails_helper'

RSpec.describe Like, type: :model do
  before :each do
    @like = build(:like)
  end
  
  it "is valid" do
    expect(@like).to be_valid
  end
  
  
end
