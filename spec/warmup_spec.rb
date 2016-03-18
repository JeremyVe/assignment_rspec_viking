require 'warmup'

describe Warmup do
  let(:warmup) {Warmup.new}
  describe "#gets_shout" do
    it "should gets input and return the shouted version" do
      allow(warmup).to receive(:gets).and_return("hello")
      expect(warmup.gets_shout).to eq("HELLO")
    end
  end

  describe "#triple_size" do
    it "should return a triple size" do
      array_double = instance_double("Array", size: 30)
      expect(warmup.triple_size(array_double)).to eq(90)
    end
  end

  describe "#calls_some_methods" do
    let(:string_double) {instance_double("string", upcase!: "STRING")}

    it "shoud fire an #upcase! method" do
      expect(string_double).to receive(:upcase!)

      warmup.calls_some_methods(string_double)
    end

    it "should fire a #reverse! method" do
      test_string = "string"
      expect(test_string).to receive(:reverse!).and_return("gnirts")

      warmup.calls_some_methods(test_string)
    end

    it "should return a different object than the one passed in" do
      return_test = warmup.calls_some_methods(string_double)
      expect(return_test).to_not eq(string_double)
    end
  end
end