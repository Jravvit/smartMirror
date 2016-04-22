class AreaSearch
  def initialize(city, country, town)
    @city = city
    @country = country
    @town = town
  end

  def parser
    address = Hash.new

    address[:city] = get_city
    address[:country] = get_country address[:city]['code']
    address[:town] = get_town address[:country]['code']

    addrValue = Hash.new
    addrValue[:addr] = address[:city]['value']+" "+address[:country]['value']+" "+address[:town]['value']
    addrValue[:x] = address[:town]['x']
    addrValue[:y] = address[:town]['y']

    addrValue
  end

  def get_city
    city = JSON.parse(Mechanize.new.get('http://www.kma.go.kr/DFSROOT/POINT/DATA/top.json.txt').body)
    city.find{|c| c['value'].include?@city }
  end

  def get_country(code)
    country = JSON.parse(Mechanize.new.get("http://www.kma.go.kr/DFSROOT/POINT/DATA/mdl.#{code}.json.txt").body)
    country.find{|c| c['value'].include?@country }
  end

  def get_town(code)
    town = JSON.parse(Mechanize.new.get("http://www.kma.go.kr/DFSROOT/POINT/DATA/leaf.#{code}.json.txt").body)
    town.find{|t| t['value'].include?@town}
  end

  private

end