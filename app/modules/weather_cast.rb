class WeatherCast

  def parser
    data_hash = Hash.from_xml(get_weathers)
    today_weather = Hash.new

    today_weather[:date] = data_hash['wid']['header']['tm'][0..7]
    today_weather[:data] = Array.new

    weather_states = {
        '맑음' => 'clean.svg',
        '구름' => 'cloud.svg',
        '비'   => 'rain.svg',
        '눈'   => 'snow.svg'
    }

    data_hash['wid']['body']['data'].each do |d|
      if d['day'] != '0' then break end
      weathers_json = Hash.new
      weathers_json[:hour] = d['hour']
      weathers_json[:state] = d['wfKor']
      weathers_json[:temp] = d['temp']

      weather_states.each do |key, value|
        if !d['wfKor'].index(key).nil? then weathers_json[:image] = value end
      end
      today_weather[:data].push(weathers_json)
    end
    today_weather
  end

  def get_weathers
    xml = Mechanize.new.get('http://www.kma.go.kr/wid/queryDFS.jsp?gridx=58&gridy=125').body
  end
end