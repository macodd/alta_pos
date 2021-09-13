class Customer {

  String _ruc;
  String _firstNames;
  String _lastNames;
  String _email;
  String _phone;

  Map<String, String> _address;

  Customer(
    this._ruc,
    this._firstNames,
    this._lastNames,
    this._email,
    this._phone,
    this._address
  );

  Customer.fromJson(ruc, data) :
    this(
      ruc,
      data['first_names'],
      data['last_names'],
      data['email'],
      data['phone'],
      {
        'street' : data['address']['street'],
        'neighborhood' : data['address']['neighborhood'],
        'city' : data['address']['city'],
        'state' : data['address']['state'],
      }
    );

  String get ruc => this._ruc;

  set ruc(String ruc) => this._ruc = ruc;

  String get firstNames => this._firstNames;

  set firstNames(String firstNames) => this._firstNames = firstNames;

  String get lastNames => this._lastNames;

  set lastNames(String lastNames) => this._lastNames = lastNames;

  String get email => this._email;

  set email(String email) => this._email = email;

  String get phone => this._phone;

  set phone(String phone) => this._phone = phone;

  String get fullName => '${_firstNames.split(" ")[0]} ${_lastNames.split(" ")[0]}';

  Map<String, String> get address => this._address;

  void setAddress(Map<String, String> address) => this._address = address;

  String? get city => this._address['city'];

  Map<String, dynamic> toJson() {
    return {
      'ruc': _ruc,
      'first_names': _firstNames,
      'last_names': _lastNames,
      'email': _email,
      'phone': _phone,
      'address': {
        'street': _address['street'],
        'neighborhood': _address['neighborhood'],
        'city': _address['city'],
        'state': _address['state'],
      }
    };
  }
}