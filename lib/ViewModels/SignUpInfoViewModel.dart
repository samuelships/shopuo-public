import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:formz/formz.dart';
import 'package:shopuo/Services/CloudFunctionService.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/Services/OverlayService.dart';
import 'package:shopuo/Validators/FormValidator.dart';
import 'package:shopuo/Validators/FullNameValidator.dart';
import 'package:shopuo/Validators/PhoneNumberValidator.dart';

import '../locator.dart';

class SignUpInfoViewModel with ChangeNotifier {
  // services
  final _navigationService = locator<NavigationService>();
  final _cloudFunctionService = locator<CloudFunctionService>();
  final _overlayService = locator<OverlayService>();

  // page data

  // other variables
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  set inProgress(value) {
    _inProgress = value;
    notifyListeners();
  }

  // validation
  FormValidator fullName = FormValidator(validators: fullNameValidators);
  FormValidator phoneNumber = FormValidator(validators: phoneNumberValidators);

  get isValid {
    final inputs = <FormzInput>[fullName.formz, phoneNumber.formz];
    return Formz.validate(inputs) == FormzStatus.valid ? true : false;
  }

  // methods
  sendInfo() async {
    if (isValid && !inProgress) {
      inProgress = true;

      try {
        var data = await _cloudFunctionService.call(
          name: "signUpInfo",
          data: {
            "full_name": fullName.formz.value,
            "phone_number": phoneNumber.formz.value,
          },
        );

        // success
        if (data["code"] == 2000) {
          _overlayService.showSnackBarSuccess(widget: Text(data["message"]));

          _navigationService.navigateTo("SignUpVerify", arguments: {
            phoneNumber: phoneNumber.formz.value,
          });
        }
      } on PlatformException catch (e) {
        //print(e);
      } finally {
        inProgress = false;
      }
    }
  }
}
