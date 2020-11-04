import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopuo/Services/AuthenticationService.dart';
import 'package:shopuo/Services/FirebaseStorageService.dart';
import 'package:shopuo/Services/FirestoreService.dart';
import 'package:shopuo/Services/NavigationService.dart';
import 'package:shopuo/Services/OverlayService.dart';
import 'package:shopuo/Validators/EmailValidator.dart';
import 'package:shopuo/Validators/FormValidator.dart';
import 'package:shopuo/Validators/FullNameValidator.dart';
import 'package:shopuo/Validators/NonEmptyTextValidator.dart';
import 'package:shopuo/Validators/PasswordValidator.dart';

import '../locator.dart';

class SettingsViewModel with ChangeNotifier {
  // services
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();
  final _overlayService = locator<OverlayService>();
  final _firebaseStorageService = locator<FirebaseStorageService>();

  // PROFILE INFORMATION
  // validation
  FormValidator fullNameForm = FormValidator(validators: fullNameValidators);
  get isFullNameValid {
    final inputs = <FormzInput>[fullNameForm.formz];
    return Formz.validate(inputs) == FormzStatus.valid ? true : false;
  }

  FormValidator emailForm = FormValidator(validators: emailValidators);
  get isEmailValid {
    final inputs = <FormzInput>[emailForm.formz];
    return Formz.validate(inputs) == FormzStatus.valid ? true : false;
  }

  FormValidator passwordForm = FormValidator(validators: passwordValidators);
  get isPasswordValid {
    final inputs = <FormzInput>[passwordForm.formz];
    return Formz.validate(inputs) == FormzStatus.valid ? true : false;
  }

  bool loadedProfileInfo = false;
  String uid;
  String _fullName = "";
  get fullName => _fullName;
  set fullName(value) {
    _fullName = value;
    notifyListeners();
  }

  String _email = "";
  get email => _email;
  set email(value) {
    _email = value;
    notifyListeners();
  }

  String profile = "https://uifaces.co/our-content/donated/KtCFjlD4.jpg";

  List<Map> sections = [
    {"heading": "", "sub heading": "Full name"},
  ];

  /// ADDRESS
  FormValidator addressName = FormValidator(validators: nonEmptyTextValidators);
  FormValidator addressDescription =
      FormValidator(validators: nonEmptyTextValidators);

  get isAddressValid {
    final inputs = <FormzInput>[
      addressName.formz,
      addressDescription.formz,
    ];
    return Formz.validate(inputs) == FormzStatus.valid ? true : false;
  }

  bool _addressInProgress = false;
  get addressInProgress => _addressInProgress;
  set addressInProgress(value) {
    _addressInProgress = value;
    notifyListeners();
  }

  addAddress() async {
    if (isAddressValid && !addressInProgress) {
      addressInProgress = true;

      try {
        await _firestoreService.addDocument(path: "addresses", data: {
          "name": addressName.formz.value,
          "description": addressDescription.formz.value,
          "user_id": uid
        });

        _overlayService.showSnackBarSuccess(
            widget: Text("Address added successfully"));

        _navigationService.popInner();
        notifyListeners();
      } catch (e) {
        print(e);
      }

      addressInProgress = false;
    }
  }

  editAddress({id}) {}

  // methods
  setUpProfile() async {
    final currentUser = _authenticationService.currentUser();
    uid = currentUser.uid;
    final userData = (await _firestoreService.getData("user_info/$uid")).data();

    sections[0]["heading"] = userData["full_name"];
    fullName = userData["full_name"];
    profile = userData["profile_photo"];

    // check if email can be updated
    final userInfo = currentUser.providerData[0];
    email = userInfo.email;

    // can only change email if signed up with email
    if (userInfo.providerId != "google.com") {
      final row = {
        "heading": userInfo.email,
        "sub heading": "Email address",
        "onTap": () {
          goToInner("ChangeEmail");
        }
      };
      if (loadedProfileInfo) {
        sections[1] = row;
      } else {
        sections.add(row);
      }
    }

    addCallbacks();
    loadedProfileInfo = true;
    notifyListeners();
  }

  setUpModel() async {
    setUpProfile();
  }

  // add ontap callbacks
  addCallbacks() {
    sections[0]["onTap"] = () {
      goToInner("ChangeName");
    };
  }

  // change name
  bool _changeNameInProgress = false;
  get changeNameInProgress => _changeNameInProgress;
  set changeNameInProgress(value) {
    _changeNameInProgress = value;
    notifyListeners();
  }

  changeName() async {
    if (isFullNameValid && !changeNameInProgress) {
      changeNameInProgress = true;

      try {
        await _firestoreService.setData(
            path: "user_info/$uid",
            data: {"full_name": fullNameForm.formz.value});

        _overlayService.showSnackBarSuccess(
            widget: Text("Full name changed successfully"));
      } catch (e) {} finally {
        changeNameInProgress = false;
      }
      fullName = fullNameForm.formz.value;
      sections[0]["heading"] = fullName;
      notifyListeners();
    }
  }

  // change email
  bool _changeEmailInProgress = false;
  get changeEmailInProgress => _changeEmailInProgress;
  set changeEmailInProgress(value) {
    _changeEmailInProgress = value;
    notifyListeners();
  }

  changeEmail() async {
    if (!changeNameInProgress) {
      changeEmailInProgress = true;

      try {
        await _authenticationService.changeEmail(emailForm.formz.value);
        _overlayService.showSnackBarSuccess(
            widget: Text("Email changed successfully"));
      } on FirebaseAuthException catch (e) {
        if (e.code == "requires-recent-login") {
          emailForm.localError = "Changing your email requires recent login";
        }
      } finally {
        changeEmailInProgress = false;
      }
      email = _authenticationService.currentUser().email;
      sections[1]["heading"] = email;
      notifyListeners();
    }
  }

  // upload profile
  bool _uploadProfileInProgress = false;
  get uploadProfileInProgress => _uploadProfileInProgress;
  set uploadProfileInProgress(value) {
    _uploadProfileInProgress = value;
    notifyListeners();
  }

  uploadProfile() async {
    if (!uploadProfileInProgress) {
      uploadProfileInProgress = true;

      final pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
      );

      if (pickedFile != null) {
        try {
          final downloadUrl = await _firebaseStorageService.uploadFile(
            file: File(pickedFile.path),
            title: "$uid/profile_",
          );

          await _firestoreService.setData(
            path: "user_info/$uid",
            data: {"profile_photo": downloadUrl},
          );

          profile = downloadUrl;
          notifyListeners();
        } catch (e) {
          print(e);
        }
      }

      uploadProfileInProgress = false;
    }
  }

  //  change password
  bool _changePasswordInProgress = false;
  get changePasswordInProgress => _changePasswordInProgress;
  set changePasswordInProgress(value) {
    _changePasswordInProgress = value;
    notifyListeners();
  }

  changePassword() async {
    if (!changePasswordInProgress && isPasswordValid) {
      changePasswordInProgress = true;

      try {
        await _authenticationService.changePassword(passwordForm.formz.value);
        _overlayService.showSnackBarSuccess(
            widget: Text("Password changed successfully"));
      } on FirebaseAuthException catch (e) {
        if (e.code == "requires-recent-login") {
          passwordForm.localError =
              "Changing your password requires recent login";
        }
      } finally {
        changePasswordInProgress = false;
      }
    }
  }

  logOut() async {
    await _authenticationService.logout();
    await _navigationService.navigateToAndClear("SignIn");
  }

  goToProfile() async {
    await _navigationService.navigateInner("Profile");
  }

  goToInner(String route) async {
    await _navigationService.navigateInner(route);
  }
}
