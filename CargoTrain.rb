class CargoTrain < Train
  def initialize(number, type = 'грузовые')
    super
  end

  def add_car(car)
    if car.instance_of?(CargoCar)
      super(car)
    else
      puts 'К грузовому поезду нельзя прицеплять пассажирские вагоны'
    end
  end
end

