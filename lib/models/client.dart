class Client {

  String ruc;
  String firstNames;
  String lastNames;
  String email;

  Address? address;

  Client(this.ruc, this.firstNames, this.lastNames, this.email,);

  void setAddress(Address address) {
    this.address = address;
  }

  Map<String, dynamic> toJson() {
    return {
      'ruc': this.ruc,
      'firstNames': this.firstNames,
      'lastNames': this.lastNames,
      'email': this.email,
      'address': this.address!.toJson()
    };
  }

}

class Address {

  String city;
  String state;
  String neighborhood;
  String street;

  Address(this.city, this.state, this.neighborhood, this.street);

  Map<String, String> toJson() {
    return {
      'city': this.city,
      'state': this.state,
      'neighborhood': this.neighborhood,
      'street': this.street
    };
  }
}