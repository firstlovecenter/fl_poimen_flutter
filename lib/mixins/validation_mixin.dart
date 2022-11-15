class ValidationMixin {
  String validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return '';
  }

  String validateEmail(String? value) {
    // return null if valid
    if (value == '' || value == null) {
      return 'You must enter an email address';
    }

    // otherwise string with error message if invalid
    if (!value.contains('@')) {
      return 'Please enter a valid email';
    }
    return '';
  }

  String validatePassword(String? value) {
    // return null if valid
    if (value == '' || value == null) {
      return 'You must enter a password';
    }

    // otherwise string with error message if invalid
    if (value.length < 4) {
      return 'Please enter a valid password';
    }

    return '';
  }
}
