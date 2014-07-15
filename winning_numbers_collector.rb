require 'selenium-webdriver'
require 'Date'

class WinningNumbersCollector

  # def self.build()
  #   new(Selenium::WebDriver.for :firefox)
  # end

  # attr_reader :driver

  # def initialize(driver)
  #   @driver = driver
  # end

  def collect(lottery_date)

    @driver = Selenium::WebDriver.for :firefox
    @driver.navigate.to get_url_for lottery_date

    rows = get_rows_with @driver

    drawings = drawify rows

    @driver.quit

    selected_drawing = drawings[lottery_date]

    if selected_drawing.nil?
      fail "#{lottery_date} is a non-existing lottery date."
    end

    selected_drawing

  end

  def get_url_for(lottery_date)
    month = lottery_date.mon
    year = lottery_date.year
    start_date = Date.new(year, month, 1)
    end_date = Date.new(year, month, 31)

    "http://www.megamillions.com/winning-numbers/search?startDate=#{start_date.strftime('%-m/%-d/%Y')}&endDate=#{end_date.strftime('%-m/%-d/%Y')}"
  end

  def get_rows_with(driver)
    table = @driver.find_element(:class, 'winning-numbers-table')
    tbody = table.find_element(:tag_name, 'tbody')
    tbody.find_elements(:tag_name, 'tr')
  end

  def drawify(rows)
    drawings = Hash.new
    rows.each do |row|
      drawing = get_drawing row
      drawings[drawing.date] = drawing
    end

    drawings
  end

  def get_drawing(row)
    columns = row.find_elements(:tag_name, 'td')
    date = Date.strptime(columns[0].text, '%m/%d/%Y')
    numbers = [columns[1].text, columns[2].text, columns[3].text, columns[4].text, columns[5].text]
    mega_ball = columns[6].text

    Drawing.new(date, numbers, mega_ball)
  end

  Drawing = Struct.new(:date, :numbers, :mega_ball)

  private :get_url_for, :get_rows_with, :drawify, :get_drawing

end
