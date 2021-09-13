/// User Profile class
/// ------------------
/// creates a profile from the information given from
/// the backend (firebase)
class Profile {

  // name and email of user
  String _name;
  String _email;
  String _uid;

  Profile(this._name, this._email, this._uid);

  // get user name
  String get name => this._name;

  // get user email
  String get email => this._email;

  //get uid (username)
  String get uid => this._uid;
}
