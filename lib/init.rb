require 'open-uri'
require 'nokogiri'
require 'date'
require 'time'
require 'pry'
require 'pry-byebug'
require 'i18n'
# require 'mechanize'


Dir[File.expand_path('../**.rb', __FILE__)].each { |f| require(f) }
# localizations = Dir[File.expand_path('../**/**.yml', __FILE__)] # искать по всем папкам
localizations = Dir[File.expand_path('../../config/locales/*.yml', __FILE__)] # искать только в ./config/locales/

# инициализация локализации
I18n.load_path += localizations
I18n.config.default_locale = :ru

# I18n.config.available_locales = :en
# I18n.localize(Date.parse(date), :format => '%a', :locale => 'en')
# I18n.localize(Date.parse(date), :format => '%A %e %B') # => "пятница 17 апреля"


# # binding.pry


# p sinoptic
# binding.pry



# binding.pry

# @sinoptic = sinoptic
# sinoptic.scrape
# binding.pry
# puts sinoptic.get



