class Route
  attr_reader :stations

  def initialize(from, to)
    @stations = [from, to]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    return if [stations.first, stations.last].include?(station)

    @stations.delete(station)
  end

  def show_stations
    @stations.each_with_index { |station, i| puts "#{i + 1}. #{station.name}" }
  end
end
