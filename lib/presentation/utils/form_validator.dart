class FormValidator {
  static String? emailValidator(String? value) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@+")
            .hasMatch(value!)
        ? null
        : "Enter correct email";
  }

  static bool isPasswordCompliant(String password, [int minLength = 8]) {
    if (password == null || password.isEmpty) {
      return false;
    }

    bool hasUppercase = password.contains(RegExp(r'[A-Z]'));
    bool hasDigits = password.contains(RegExp(r'[0-9]'));
    bool hasLowercase = password.contains(RegExp(r'[a-z]'));
    // bool hasSpecialCharacters =
    //     password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    bool hasMinLength = password.length >= minLength;

    return hasDigits &
        hasUppercase &
        hasLowercase &
        // hasSpecialCharacters &
        hasMinLength;
  }

  static String? passwordValidation(String? value) {
    if (value!.isEmpty) {
      return 'Enter a valid password';
    } else {
      if (value.length < 8) {
        return "This password is too short. It must contain at least 8 characters.";
      }
    }
    return null;
  }

  static String? confPasswordValidation(String? value, String password) {
    if (value!.isEmpty) {
      return 'Enter a valid password';
    } else {
      if (value != password) {
        return "Password not matched";
      }
    }
    return null;
  }

  static String? profileValidation(String? value) {
    if (value!.isEmpty) {
      return 'Profile information can not be empty';
    }
    return null;
  }

  static String? phoneNumberValidation(String? value, String? country) {
    print("===================>>>>> $country");
    if (value!.isEmpty) {
      return 'Phone number can be empty';
    } else {
      switch (country) {
        case "BD +880":
          if (value.length < 10) return "Phone number must contains 10 digits";
          break;
        case "FR +33":
          return RegExp("^((+)33|0)[1-9](\d{2}){4}").hasMatch(value)
              ? null
              : "Invalid number";
      }
    }
    return null;
  }

  static bool validateAndSave(globalFormKey) {
    final form = globalFormKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}
