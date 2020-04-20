
# в идеале класс должен принимать url и способ парсинга (как решить выбор города?)
# иметь метод:
# scrape или parse - обновление данных о погоде (если нужно парсить)
# fetch - если получить по API
# store - сохранение в базу
# get - получить текущие данные (если прошло много времени, то обновить)
# можно было бы через accessor, но тогда как реализовать логику проверки свежести данных?
class Weather
  def initialize(url, parser, exp_interval)
    @url = url
    @parser = parser.new(@url)
    @week_weather_data = []
    @day_weather_data = []
    @expiration = Time.now.to_i
    @exp_interval = exp_interval
  end

  def scrape_week
    @expiration = Time.now.to_i
    @week_weather_data[0] = @parser.scrape_week

  end

  def scrape_day
    @expiration_d = Time.now.to_i
    @expiration_w = Time.now.to_i
    @day_weather_data[0] = @parser.scrape_day

  end

  def get_week
    # if data is fresh
    if (Time.now.to_i - @expiration_w) > @exp_interval # если после последнего парсинга прошло больше чем
      @expiration_w = Time.now.to_i
      scrape_week
      @week_weather_data[1] = 'fresh'
    else
      @week_weather_data[1] = 'cash'
    end
    @week_weather_data
  end

  def get_day
    # if data is fresh
    if (Time.now.to_i - @expiration_d) > @exp_interval # если после последнего парсинга прошло больше чем
      @expiration_d = Time.now.to_i
      scrape_day
      @day_weather_data[1] = 'fresh'
    else
      @day_weather_data[1] = 'cash'
    end
    @day_weather_data
  end

end