require File.join(File.dirname(__FILE__), '..', 'WinningNumbersCollector')

describe WinningNumbersCollector do

  describe 'given non-existing lottery date' do
    collector = WinningNumbersCollector.new
    nonexisting_lottery_date = Date.new(2014, 07, 13)

    it 'raises runtime error given non-existing lottery date' do
      expected_message = "#{nonexisting_lottery_date} is a non-existing lottery date."
      expect { collector.collect(nonexisting_lottery_date) }
        .to raise_error(expected_message)
    end
  end

  describe 'given existing lottery date' do
    collector = WinningNumbersCollector.new
    existing_lottery_date = Date.new(2014, 07, 11)

    it 'returns winning mega ball' do
      result = collector.collect(existing_lottery_date)
      expect(result.mega_ball).to eq("10")
    end
  end
end
