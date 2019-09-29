class PassengerTrain < Train
  def initialize(number, type = "пассажирские")
    super(number, type)
  end

  def add_car(car)
    if car.instance_of?(PassengerCar)
      super(car)
    else
      puts "К грузовому поезду нельзя прицеплять грузовые вагоны"
    end
  end
end


