class FormValidator {
  FormValidator._();

  //==============================
  // REQUIRED
  //==============================

  static String? required(
      String? value, {
        String message = "This field is required",
      }) {
    if (value == null || value.trim().isEmpty) {
      return message;
    }

    return null;
  }

  //==============================
  // EMAIL
  //==============================

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Email is required";
    }

    final regex = RegExp(
      r'^[\w\.-]+@([\w-]+\.)+[A-Za-z]{2,}$',
    );

    if (!regex.hasMatch(value.trim())) {
      return "Invalid email address";
    }

    return null;
  }

  //==============================
  // PASSWORD
  //==============================

  static String? password(
      String? value, {
        int minLength = 6,
      }) {
    if (value == null || value.isEmpty) {
      return "Password is required";
    }

    if (value.length < minLength) {
      return "Minimum $minLength characters";
    }

    return null;
  }

  //==============================
  // CONFIRM PASSWORD
  //==============================

  static String? confirmPassword({
    required String? password,
    required String? confirmPassword,
  }) {
    if (confirmPassword == null || confirmPassword.isEmpty) {
      return "Please confirm your password";
    }

    if (password != confirmPassword) {
      return "Passwords do not match";
    }

    return null;
  }

  //==============================
  // MIN LENGTH
  //==============================

  static String? minLength(
      String? value,
      int length,
      ) {
    if (value == null || value.length < length) {
      return "Minimum $length characters";
    }

    return null;
  }

  //==============================
  // MAX LENGTH
  //==============================

  static String? maxLength(
      String? value,
      int length,
      ) {
    if (value != null && value.length > length) {
      return "Maximum $length characters";
    }

    return null;
  }

  //==============================
  // PHONE
  //==============================

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Phone number is required";
    }

    final regex = RegExp(r'^[0-9+\s()-]{6,20}$');

    if (!regex.hasMatch(value.trim())) {
      return "Invalid phone number";
    }

    return null;
  }

  //==============================
  // NUMBER
  //==============================

  static String? number(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Value is required";
    }

    if (double.tryParse(value) == null) {
      return "Invalid number";
    }

    return null;
  }

  //==============================
  // URL
  //==============================

  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final regex = RegExp(
      r'^(https?:\/\/)?([\w-]+\.)+[\w-]+(\/[\w\-./?%&=]*)?$',
    );

    if (!regex.hasMatch(value.trim())) {
      return "Invalid URL";
    }

    return null;
  }

  //==============================
  // USERNAME
  //==============================

  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Username is required";
    }

    if (value.length < 3) {
      return "Minimum 3 characters";
    }

    return null;
  }

  //==============================
  // GENERIC TEXT
  //==============================

  static String? text(
      String? value, {
        int min = 1,
        int max = 255,
        String field = "Field",
      }) {
    if (value == null || value.trim().isEmpty) {
      return "$field is required";
    }

    if (value.trim().length < min) {
      return "$field must contain at least $min characters";
    }

    if (value.trim().length > max) {
      return "$field cannot exceed $max characters";
    }

    return null;
  }
}