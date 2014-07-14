require File.join(File.dirname(__FILE__), '..', 'LotteryValidator')

describe LotteryValidator do
  describe 'Validation' do
    it 'returns true if it is a winning combination for the given week' do
      validator = LotteryValidator.new
      lottery_date = Date.new(2014, 07, 13)
      result = validator.validate(lottery_date)
      expect(result).to be true
    end
  end
end
