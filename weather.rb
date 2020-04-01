require 'open-uri'
require 'nokogiri'
require 'date'
require 'time'

# class weather
class Weather

  # attr_reader hh = {}
  attr_reader :days
  attr_reader :temp

  def initialize(url)
    @days = []
    @temp = []
    @url = url
    @doc = Nokogiri::HTML(open(@url))
  end

  def parse_weather
    @doc.xpath('//div[contains(@class, "main ")]/p').each_with_object([]) do
    |n| @days << n.text
    end
    @doc.xpath('//div[contains(@class, "main ")]/div[@class="temperature"]//span').each_with_object([]) do
    |n| @temp << n.text
    end
  end
end

# url = 'https://sinoptik.ua/'
# sinoptic = Weather.new(url)
# sinoptic.parse_weather
# puts "#{sinoptic.days} #{sinoptic.temp}"