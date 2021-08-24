/// User Profile class
/// ------------------
/// creates a profile from the information given from
/// the backend (firebase)
class Profile {

  // name and email of user
  String _name;
  String _email;
  String _username;
  String _uid;

  Profile(this._name, this._email, this._username, this._uid);

  // get user name
  String getName() => _name;

  // get user email
  String getEmail() => _email;

  // get username
  String getUsername() => _username;

  String getUid() => _uid;
}
