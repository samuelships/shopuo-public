import 'package:formz/formz.dart';

class FormValidator {
  List<Function(String value)> validators;
  String localError;

  FormzInput<String, String> formz;

  reset() {
    formz = Input.pure(validators: validators);
  }

  get error {
    if (localError != null)
      return localError;
    else
      return formz.invalid ? formz.error : null;
  }

  change(value) {
    formz = Input.dirty(value: value, validators: validators);
    localError = null;
  }

  FormValidator({this.validators}) : formz = Input.pure(validators: validators);
}

class Input extends FormzInput<String, String> {
  myValidator(value, functions) {
    for (var func in functions) {
      var result = func(value);
      if (result != null) {
        return result;
      }
    }
    return null;
  }

  List<Function(String string)> validators;

  Input.pure({this.validators}) : super.pure('');
  Input.dirty({this.validators, value}) : super.dirty(value);

  @override
  String validator(string) => myValidator(string, validators);
}
