class HvsUser {
  String _nameSurname;
  String get name => _nameSurname;
  set name(String value) {
    if (value != null) {
      _nameSurname = value;
    }
  }

  String _email;
  String get email => _email;

  set email(String value) {
    if (value != null) {
      _email = value;
    }
  }

  String _password;
  String get password => _password;
  set password(String value) {
    if (value != null) {
      _password = value;
    }
  }
}
