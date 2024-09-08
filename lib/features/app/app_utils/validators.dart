class Validators {
  RegExp regExpUpperCase = RegExp(r'^(?=.*[A-Z])');
  RegExp regExpLowerCase = RegExp(r'^(?=.*[a-z])');
  RegExp regExpDigit = RegExp(r'^(?=.*?[0-9])');
  RegExp regExpSpeciaCharacter = RegExp(r'^(?=.*?[!@#\$&*~])');
  RegExp regExpLength = RegExp(r'^.{8,}');
  RegExp regExpPhoneNumber = RegExp(r'^(\+|00)?[0-9]+$');
  RegExp regExpEmail = RegExp(
      r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
      r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
      r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
      r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
      r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
      r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
      r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])');

  String? validateUpperAndLowerCase(value) {
    return value!.isEmpty
        ? 'This field is empty.'
        : !regExpUpperCase.hasMatch(value)
            ? 'There is not a capital letter.'
            : !regExpLowerCase.hasMatch(value)
                ? 'There is not a regular letters.'
                : null;
  }

  String? validateEmail(value) {
    return value!.isEmpty
        ? 'This field is empty.'
        : !regExpEmail.hasMatch(value)
            ? 'Email is not valid.'
            : null;
  }

  String? validatePhoneNumber(value) {
    return value!.isEmpty
        ? 'This field is empty.'
        : !regExpPhoneNumber.hasMatch(value)
            ? 'Phone number is not valid.'
            : null;
  }

  String? validatePassword(value) {
    return value!.isEmpty
        ? 'This field is empty'
        : !regExpUpperCase.hasMatch(value)
            ? 'Password must contain at least one capital letter.'
            : !regExpLowerCase.hasMatch(value)
                ? 'Password must contain at least one regular letter.'
                : !regExpDigit.hasMatch(value)
                    ? 'Password must contain at least one digit.'
                    : !regExpSpeciaCharacter.hasMatch(value)
                        ? 'Password must contain at least one special character.'
                        : !regExpLength.hasMatch(value)
                            ? 'Password must be at least 8 characters long.'
                            : null;
  }
}
