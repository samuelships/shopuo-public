import 'FormValidator.dart';

final emailRegExp = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

FormValidator emailValidator = FormValidator(
  validators: [
    (value) => value.isNotEmpty ? null : "This field is required",
    (value) => emailRegExp.hasMatch(value) ? null : "Email is invalid",
  ],
);
