final phoneNumberRegex = RegExp(r'^(?:[+0]9)?[0-9]{10}$');

final phoneNumberValidators = [
  (value) => value.isNotEmpty ? null : "This field is required",
  (value) =>
      phoneNumberRegex.hasMatch(value) ? null : "Phone number is invalid",
];
