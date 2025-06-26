
class Vehicle {
  // Base class method
  String move() {
    return "The vehicle moves.";
  }
}

class Bicycle extends Vehicle {
  // Derived class overriding the move() method
  @override
  String move() {
    return "The bicycle pedals forward.";
  }
}
