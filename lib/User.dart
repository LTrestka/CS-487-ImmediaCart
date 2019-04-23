class User{

  String name;
  String address;
  String city;
  String state;
  String cardNumber;
  String cardType;
  String cardExpire;
  String phoneNumber;
  String location;

  User(this.name, this.address, this.city, this.state, this.cardNumber,
      this.cardType, this.cardExpire);

  void addPhoneNumber(String number){
    this.phoneNumber = number;
  }
  void updateLocation(String location){
    this.location = location;
  }

  @override
  String toString() {
    return 'User{name: $name, address: $address, city: $city, state: $state, cardNumber: $cardNumber, cardType: $cardType, cardExpire: $cardExpire, phoneNumber: $phoneNumber, location: $location}';
  }


}