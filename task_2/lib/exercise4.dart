

class Car {
  // Properties of the Car class
  String make;
  String model;
  int year;

  // Constructor for the Car class
  Car(this.make, this.model, this.year);

  // Method to display car details
  String getCarDetails() {
    return "Car Details: Make - $make, Model - $model, Year - $year";
  }
}
