bool isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}

final cardYearValidators = [
  (value) => value.isNotEmpty ? null : "This field is required",
  (value) => isNumeric(value) ? null : "Enter a valid pin",
  (value) => value.length == 4 ? null : "Pin must be a 4 digit integer",
];
