

class Student {
  // Private properties (conventionally prefixed with an underscore)
  String _name;
  int _age;

  // Constructor
  Student(this._name, this._age);

  // Getter for name
  String get name => _name;

  // Setter for name
  set name(String newName) {
    if (newName.isNotEmpty) {
      _name = newName;
    } else {
      print("Name cannot be empty.");
    }
  }

  // Getter for age
  int get age => _age;

  // Setter for age
  set age(int newAge) {
    if (newAge > 0) {
      _age = newAge;
    } else {
      print("Age must be a positive number.");
    }
  }

  // Method to display student details
  String getStudentDetails() {
    return "Student Details: Name - $_name, Age - $_age";
  }
}
