extension ExtString on String {
  //Email validation
  bool get isValidEmail {
    final emailRegex = RegExp(r'^[a-zA-Z]{3}.[0-9]{4}@reg.co$');
    return emailRegex.hasMatch(this);
  }

//Password validation
  bool get isValidPassword {
    final passwordRegex =
        RegExp(r'^(?=.{8,}$)(?=.*[0-9])(?=.*[!$#^*])[a-zA-Z0-9!$#^*]+$');
    return passwordRegex.hasMatch(this);
  }
}
