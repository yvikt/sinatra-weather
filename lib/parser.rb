module Parser

  class Sinoptic

    def initialize(url)
      @url = url
    end

    def scrape_week
      weather = [] # массив хешей для кажного дня прогноза
      @dates_string = [] # строки типа 2020-04-17 извлеченные из HTML data-link="//sinoptik.ua/погода-одесса/2020-04-17"
      @dates = [] # даты - объекты Date

      @doc = Nokogiri::HTML(open(@url))

      @doc.xpath('//*[@class="day-link"]').each do |node| # все узлы HTML c class="day-link"
        string = node.attribute('data-link').value.split('/').last
        @dates_string << string
        @dates << Date.parse( string ) # объекты Date из строк-дат
      end

      temp = []
      @doc.xpath('//div[contains(@class, "main ")]/div[@class="temperature"]//span').each_with_object([]) { |n| temp << n.text }
      temp_a = temp.each_slice(2).to_a

      img_links = @doc.xpath('//div[@class="tabs"]//img[@class="weatherImg"]/@src').map(&:value)
      sky = @doc.xpath('//div[@class="tabs"]//div[contains(@class, "weatherIco")]/@title').map(&:value)

      @dates.each_with_index do |d, i|
        # данные одного дня
        day = {
                date: '',
                temp: {min: '', max: '', feel: ''},
                img_link: '',
                sky: ''
                # wind: {speed: '', direction: ''},
                # precipitation: '',
                # sky: '',
                # humidity: '',
                # pressure: ''
        }
        day[:date] = d # объект Date
        day[:temp][:min] = temp_a[i][0]
        day[:temp][:max] = temp_a[i][1]
        day[:img_link] = img_links[i]
        day[:sky] = sky[i]
        weather[i] = day
      end
      # binding.pry
      weather # возвращаем массив хешей
    end


    def scrape_day
      # парсинг таблицы с подробной погодой на один день
      table = @doc.xpath('//table[@class="weatherDetails"]')

      # время суток
      day_time = table.xpath('//thead/tr/td').map(&:text)

      # временнЫе прмежутки
      time_slot = table.xpath('//tbody/tr[1]/td').map(&:text)

      # облачность
      sky_description = table.xpath('//tbody/tr[2]/td/div[@title]/@title').map(&:text)
      # sky = table.xpath('//tbody/tr[2]/td/div[@title]').map(&:values) #[["weatherIco n200", "Переменная облачность"], ["weatherIco n300", "Облачно с прояснениями"],....
      sky_ico = table.xpath('//tbody/tr[2]/td/div[@title]/@class').map(&:text).map(&:split).map(&:pop)

      temp_fact = table.xpath('//tbody/tr[3]/td').map(&:text)

      temp_feel = table.xpath('//tbody/tr[4]/td').map(&:text)

      pressure = table.xpath('//tbody/tr[5]/td').map(&:text)

      humiditi = table.xpath('//tbody/tr[6]/td').map(&:text)

      wind = table.xpath('//tbody/tr[7]/td/div').map(&:text) #; wind << n.attribute('data-tooltip').value }

      veroyatnost = table.xpath('//tbody/tr[8]/td').map(&:text)

      one_day = []
      one_day[0] = @dates[0] # объект Date этого дня

      # возвращаем массив подробностей одного дня
      one_day[1] = [day_time, time_slot, sky_ico, temp_fact, temp_feel, pressure, humiditi, wind, veroyatnost, sky_description]
      # binding.pry
      one_day
    end

  end



  class MeteoGov

  end

  class Gismeteo

  end

end
