bool isNumeric(String str) {
  if (str == null) {
    return false;
  }
  return double.tryParse(str) != null;
}

final cardCvvValidators = [
  (value) => value.isNotEmpty ? null : "This field is required",
  (value) => isNumeric(value) ? null : "Enter a valid pin",
  (value) => value.length == 3 ? null : "Pin must be a 3 digit integer",
];
