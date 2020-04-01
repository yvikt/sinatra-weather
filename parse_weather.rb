# парсим погоду с нескольких сайтов
# долой рекламу !

require 'open-uri'
require 'nokogiri'
require 'date'
require 'time'

# Одесса
urls = %w[ https://sinoptik.ua/
           https://sinoptik.ua/%D0%BF%D0%BE%D0%B3%D0%BE%D0%B4%D0%B0-%D0%BE%D0%B4%D0%B5%D1%81%D1%81%D0%B0
           https://www.gismeteo.ua/weather-odessa-4982/10-day/
           https://meteo.gov.ua/ua/33837 ]
# puts urls
weather = []
# weather = [
#   {
#     url_source: 'site',
#     data: {
#       date: 'month_day',
#       day: 'week_day',
#       min_temp: 'degrees',
#       max_temp: 'degrees'
#     }
#   }
# ]

weather_by_dates =
    [
        {
            date: {
                service_url: '',
                temp: ''
            }
        }
    ]

monthes = {
    января: 1,
    февраля: 2,
    марта: 3,
    апреля: 4,
    мая: 5,
    июня: 6,
    июля: 7,
    августа: 8,
    сентября: 9,
    октября: 10,
    ноября: 11,
    декабря: 12}



days = []
temp = []

doc = Nokogiri::HTML(open(urls[0]))

doc.xpath('//div[contains(@class, "main ")]/p').each_with_object([]) { |n| days << n.text }
doc.xpath('//div[contains(@class, "main ")]/div[@class="temperature"]//span').each_with_object([]) { |n| temp << n.text }

# p days
# p temp

site = {}
site[:url_source] = urls[0]

days_a = days.each_slice(3).to_a
puts days_a.length
temp_a = temp.each_slice(2).to_a
puts temp_a.length
# p temp_a
# for i in 0..6 do
# p days_a[i][0], days_a[i][1], days_a[i][2], temp_a[i][0], temp_a[i][1]
# end
# i = 0

data_a = []
for i in 0..days_a.length - 1 do
  data = {}
  # data[:week_day] = days_a[i][0]
  data[:date] = "#{days_a[i][1]}.0#{monthes[days_a[i][2].to_sym]}.20"
  # data[:month] = days_a[i][2]
  data[:min_temp] = temp_a[i][0]
  data[:min_max] = temp_a[i][1]
  data_a[i] = data
end

site[:data] = data_a
weather[0] = site
p weather


# meteo.gov.ua Український гідрометеорологічний центр

doc = Nokogiri::HTML(open(urls[3], { ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE }))
days = []
temp = []
wind_direction = []
wind_speed = []
# даты массив из 5 элементов
doc.xpath('//tr[1]/td').each_with_object([]) { |d| days << d.text.strip }
# температуры массив из 10 элементов
doc.xpath('//tr[4]/td').each_with_object([]) { |d| temp << d.text.strip }
# скорость ветра
doc.xpath('//tr[5]/td').each_with_object([]) { |d| wind_speed << d.text.strip }
# направление ветра
doc.xpath('//tr[6]/td//img/@title').each_with_object([]) { |d| wind_direction << d.text.strip }

days.shift # удаление слова "ПрогнозПогоди"
temp.shift # удаление слова "Температура, °C"
wind_speed.shift # удаление слова "Вітер, м/c"
p days
p temp
p wind_speed
p wind_direction





# data = {}
# if i % 3 == 0
#   data[:week_d] = v
# end
# if
# (i + 1) % 3 == 0
#   data[:month] = v
# end
# if (i + 2) % 3 == 0
#   data[:date] = v
#   data_ar << data
#   data = {}
# end
# end