require 'sinatra'
require './lib/init'

urls = %w[ https://sinoptik.ua/
             https://sinoptik.ua/%D0%BF%D0%BE%D0%B3%D0%BE%D0%B4%D0%B0-%D0%BE%D0%B4%D0%B5%D1%81%D1%81%D0%B0
             https://sinoptik.ua/%D0%BF%D0%BE%D0%B3%D0%BE%D0%B4%D0%B0-%D0%BE%D0%B4%D0%B5%D1%81%D1%81%D0%B0/10-%D0%B4%D0%BD%D0%B5%D0%B9
             https://www.gismeteo.ua/weather-odessa-4982/10-day/
             https://meteo.gov.ua/ua/33837 ]

@exp_interval = 10 # устаревание данных 10 секунд
sinoptic = Weather.new(urls[2], Parser::Sinoptic, @exp_interval)
sinoptic.scrape_week
sinoptic.scrape_day

get '/' do
  week = sinoptic.get_week
  @week = week[0]
  @cache_status_week = week[1]

  one_day = sinoptic.get_day
  @one_day = one_day[0]
  @cache_status_day = one_day[1]

  I18n.config.locale = :ru
  erb :sinoptic
end

get '/en' do
  @week = sinoptic.get_week[0]
  @one_day = sinoptic.get_day[0]
  I18n.config.locale = :en
  erb :sinoptic
end

get '/ua' do
  @week = sinoptic.get_week[0]
  @one_day = sinoptic.get_day[0]
  I18n.config.locale = :uk
  erb :sinoptic
end

get '/info' do
  erb :info
end