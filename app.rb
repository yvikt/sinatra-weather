#encoding: utf-8
require 'rubygems'
require 'sinatra'
# require 'sinatra/reloader'
require './weather'

require 'open-uri'
require 'nokogiri'
require 'date'
require 'time'

get '/' do
  erb :main
end

get '/sinoptic' do
  url = 'https://sinoptik.ua/'
  sinoptic = Weather.new(url)
  sinoptic.parse_weather

  erb :sinoptic, locals: { sinoptic: sinoptic }
end

get '/meteo_gov_ua' do
  erb :meteo_gov_ua
end

get '/gismeteo' do
  erb :gismeteo
end

get '/table' do
  erb :table
end

get '/info' do
  erb :info
end