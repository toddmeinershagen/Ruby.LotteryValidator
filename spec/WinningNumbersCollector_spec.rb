require File.join(File.dirname(__FILE__), '..', 'WinningNumbersCollector')

describe WinningNumbersCollector do

  describe "given non-existing lottery date" do
    collector = WinningNumbersCollector.new
    nonexistingLotteryDate = Date.new(2014, 07, 13)

    it "raises runtime error given non-existing lottery date" do
      expect {result = collector.collect(nonexistingLotteryDate)}.to raise_error("#{nonexistingLotteryDate} is a non-existing lottery date.")
    end
  end

=begin
  describe "given existing lottery date" do
    collector = WinningNumbersCollector.new
    existingLotteryDate = Date.new(2014, 07, 11)

    it "returns winning mega ball" do
      result = collector.collect(existingLotteryDate)
      expect(result.mega_ball).to eq(10)
    end
  end
=end

end
