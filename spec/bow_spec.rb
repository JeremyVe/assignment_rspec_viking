require "weapons/bow"

describe Bow do
  let(:bow) {Bow.new}
  describe "#arrows" do

    it "should be readable" do
      expect(bow.arrows).to_not be_nil
    end

    it "should initialize with 10 arrows" do
      expect(bow.arrows).to eq(10)
    end

    it "takes specified arrow numbers" do
      bow = Bow.new(5)
      expect(bow.arrows).to eq(5)
    end
  end

  describe "#use" do
    it "should deduct 1 arrow" do
      bow.use
      expect(bow.arrows).to eq(9)
    end

    it "should raise error if 0 arrows" do
      bow = Bow.new(0)
      expect{bow.use}.to raise_error(RuntimeError)
    end
  end
end