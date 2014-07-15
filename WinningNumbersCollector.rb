require 'selenium-webdriver'
require 'Date'

class WinningNumbersCollector

  #def self.build()
  #    new(Selenium::WebDriver.for :firefox)
  #end

  #attr_reader :driver

  #def initialize(driver)
  #  @driver = driver
  #end

  def collect(lottery_date)

    month = lottery_date.mon
    year = lottery_date.year
    start_date = Date.new(year, month, 1)
    end_date = Date.new(year, month, 31)

    @driver = Selenium::WebDriver.for :firefox
    @driver.navigate.to "http://www.megamillions.com/winning-numbers/search?startDate=#{start_date.strftime('%-m/%-d/%Y')}&endDate=#{end_date.strftime('%-m/%-d/%Y')}"

    table = @driver.find_element(:class, 'winning-numbers-table')
    tbody = table.find_element(:tag_name, 'tbody')
    rows = tbody.find_elements(:tag_name, 'tr')

    drawings = Hash.new
    rows.each do |row|
      drawing = get_drawing row
      drawings[drawing.date] = drawing
    end

    @driver.quit

    selected_drawing = drawings[lottery_date]

    if selected_drawing.nil?
      fail "#{lottery_date} is a non-existing lottery date."
    end

    selected_drawing

  end

  def get_drawing(row)
    columns = row.find_elements(:tag_name, 'td')
    date = Date.strptime(columns[0].text, '%m/%d/%Y')
    numbers = [columns[1].text, columns[2].text, columns[3].text, columns[4].text, columns[5].text]
    mega_ball = columns[6].text

    Drawing.new(date, numbers, mega_ball)
  end

  Drawing = Struct.new(:date, :numbers, :mega_ball)

end
