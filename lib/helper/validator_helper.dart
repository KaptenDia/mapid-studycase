String? requiredValidator(
  String? value, {
  String message = 'Kolom tidak boleh kosong',
}) {
  if (value == null || value.trim().isEmpty) {
    return message;
  }
  return null;
}

String? fullNameValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Kolom tidak boleh kosong';
  }

  if (value.trim().length < 3) {
    return 'Nama minimal 3 karakter';
  }

  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value.trim())) {
    return 'Nama hanya boleh berisi huruf';
  }

  return null;
}

String? emailValidator(String? value) {
  RegExp regex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  if (value != null) {
    if (value.isEmpty) {
      return 'Kolom tidak boleh kosong';
    } else if (!regex.hasMatch(value)) {
      return 'Email tidak valid';
    }
  }
  return null;
}

String? phoneValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return 'Kolom tidak boleh kosong';
    } else if (!value.startsWith('08')) {
      return "Nomor harus berawalan '08', contoh: 08xxx";
    } else if (value.length < 10) {
      return 'Masukan minimal 10 karakter';
    }
  }
  return null;
}

String? passwordValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return 'Kolom tidak boleh kosong';
    } else if (value.length < 8) {
      return 'Masukan minimal 8 karakter';
    }
    // else if (!validatePassword(value)) {
    //   return 'Minimal mengandung 1 huruf kecil, 1 huruf besar, dan 1 angka';
    // }
  }
  return null;
}

// contains Uppercase, lowercase, number
bool validatePassword(String value) {
  String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$';
  RegExp regExp = RegExp(pattern);
  return regExp.hasMatch(value);
}

String? passwordConfirmationValidator(String? value, String? value2) {
  if (value != null) {
    if (value.isEmpty) {
      return 'Kolom tidak boleh kosong';
    } else if (value != value2) {
      return 'Kata sandi tidak sesuai';
    }
  }
  return null;
}

String? lengthMin9DigitsValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return 'Kolom tidak boleh kosong';
    } else if (value.length < 9) {
      return 'Masukan minimal 9 karakter';
    }
  }
  return null;
}

String? minimalLengthValidator(String? value, int length) {
  if (value != null) {
    if (value.isEmpty) {
      return 'Kolom tidak boleh kosong';
    } else if (value.length < length) {
      return 'Masukan minimal $length karakter';
    }
  }
  return null;
}

String? accountNumberValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return 'Kolom tidak boleh kosong';
    } else if (value.length != 16) {
      return 'Harus teridiri dari 16 karakter';
    }
  }
  return null;
}

String? linkValidator(String? value) {
  if (value != null) {
    if (value.isEmpty) {
      return null;
    } else if (!_isValidUrl(value)) {
      return 'Link tidak valid';
    }
  }
  return null;
}

bool _isValidUrl(String url) {
  RegExp regExp = RegExp(
    r'^(?:(?:https?|ftp):\/\/)?'
    r'(?:(?:[A-Z0-9][A-Z0-9_-]*)(?:\.[A-Z0-9][A-Z0-9_-]*)+|\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' // Domain atau alamat IP
    r'(?::\d+)?'
    r'(?:\/\S*)?$',
    caseSensitive: false,
  );
  return regExp.hasMatch(url);
}

String? emailOrPhoneValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Kolom tidak boleh kosong';
  }
  final emailRegex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
  final containsLetter = RegExp(r'[a-zA-Z@]').hasMatch(value);
  if (containsLetter) {
    if (!emailRegex.hasMatch(value)) {
      return 'Email tidak valid';
    }
    return null;
  }
  if (!value.startsWith('08')) {
    return "Nomor harus berawalan '08'";
  }
  if (value.length < 10) {
    return 'Masukkan minimal 10 digit';
  }
  return null;
}

String? combineValidators(
  String? value,
  List<String? Function(String?)> validators,
) {
  for (final validator in validators) {
    final result = validator(value);
    if (result != null) {
      return result;
    }
  }
  return null;
}

String formatPrice(int price) {
  return price.toString().replaceAllMapped(
    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
    (m) => '${m[1]}.',
  );
}
