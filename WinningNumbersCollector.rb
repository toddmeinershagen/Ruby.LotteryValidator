require "selenium-webdriver"

class WinningNumbersCollector

  #def self.build()
  #    new(Selenium::WebDriver.for :firefox)
  #end

  #attr_reader :driver

  #def initialize(driver)
  #  @driver = driver
  #end

  def collect(lotteryDate)

    month = lotteryDate.mon
    year = lotteryDate.year
    startDate = Date.new(year, month, 1)
    endDate = Date.new(year, month, 31)

    #profile = Selenium::WebDriver::Firefox::Profile.new
    #profile['eneral.useragent.override'] = 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:30.0) Gecko/20100101 Firefox/30.0'
    #driver = Selenium::WebDriver.for :firefox, :profile => profile

    #driver = Selenium::WebDriver.for :firefox
    #driver.navigate.to "http://www.murl.mobi/headers.php"

    @driver = Selenium::WebDriver.for :firefox
    @driver.navigate.to "http://www.megamillions.com/winning-numbers/search?startDate=#{startDate.strftime("%-m/%-d/%Y")}&endDate=#{endDate.strftime("%-m/%-d/%Y")}"

    table = @driver.find_element(:class, 'winning-numbers-table')
    tbody = table.find_element(:tag_name, 'tbody')
    rows = tbody.find_elements(:tag_name, 'tr')
    rows.each { |row| handle row }

    @driver.quit

    raise "#{lotteryDate} is a non-existing lottery date."
  end

  def handle(row)
    columns = row.find_elements(:tag_name, 'td')
    puts columns[0].text
  end

end
