import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:formz/formz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopuo/Models/AddressModel.dart';
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
  // SERVICES
  final _authenticationService = locator<AuthenticationService>();
  final _navigationService = locator<NavigationService>();
  final _firestoreService = locator<FirestoreService>();
  final _overlayService = locator<OverlayService>();
  final _firebaseStorageService = locator<FirebaseStorageService>();

  // START GENERAL -------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>

  // PAGE DATA
  List<Map<String, dynamic>> settingsSections = [
    {
      "title": "Account settings",
      "items": <Map<String, dynamic>>[
        {
          "icon": "user",
          "heading": "Profile Information",
          "sub heading": "Name, Email",
          "color": Color(0xffA6D6FF),
          "callback": (model) => model.goToProfile()
        },
        // {
        //   "icon": "lock",
        //   "heading": "Change Password",
        //   "sub heading": "Change your current password",
        //   "color": Color(0xff00C48C),
        //   "callback": (model) => model.goToInner("ChangePassword")
        // },
        {
          "icon": "map-pin",
          "heading": "Add Addresses",
          "sub heading": "Add your shipping addresses",
          "color": Color(0xff00C48C),
          "callback": (model) => model.goToInner("Address")
        },
        {
          "icon": "x-square",
          "heading": "Logout",
          "sub heading": "Logout of your account",
          "color": Color(0xffFF98A8),
          "callback": (model) => model.logOut()
        },
      ]
    },
    {
      "title": "Notifications settings",
      "items": [
        {
          "icon": "bell",
          "heading": "Push Notifications",
          "sub heading": "Turn on and off push notifications",
          "color": Color(0xffFF98A8),
          "callback": (model) => model.goToInner("PushNotification")
        }
      ]
    },
    {
      "title": "General",
      "items": [
        // {
        //   "icon": "heart",
        //   "heading": "Rate our App",
        //   "sub heading": "Rate & review us",
        //   "color": Color(0xffF6BB86)
        // },
        // {
        //   "icon": "mail",
        //   "heading": "Send Feedback",
        //   "sub heading": "Share your thought",
        //   "color": Color(0xffFFDF92)
        // },
        {
          "icon": "eye-off",
          "heading": "Privacy Policy",
          "sub heading": "Review our privacy policy",
          "color": Color(0xff96FFE1),
          "callback": (model) => model.goToInner("PrivacyPolicy")
        }
      ]
    },
  ];

  // METHODS
  setUpModel() {
    final currentUser = _authenticationService.currentUser();
    final userInfo = currentUser.providerData[0];
    if (userInfo.providerId != "google.com") {
      final itemList = (settingsSections[0]["items"]);
      itemList.insert(
        1,
        {
          "icon": "lock",
          "heading": "Change Password",
          "sub heading": "Change your current password",
          "color": Color(0xff00C48C),
          "callback": (model) => model.goToInner("ChangePassword")
        },
      );
      notifyListeners();
    }
  }

  // END GENERAL ---------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>

  // -------------------------------------------------------------------------->

  // START PROFILE INFORMATION ---->>>
  // ------------------------------>>>
  // ------------------------------>>>
  // ------------------------------>>>
  // ------------------------------>>>

  // PAGE DATA
  bool loadedProfileInfo = false;
  String profile = "https://uifaces.co/our-content/donated/KtCFjlD4.jpg";

  String currentUserId;
  List<Map> sections = [
    {"heading": "", "sub heading": "Full name"},
  ];

  bool _changeNameInProgress = false;
  get changeNameInProgress => _changeNameInProgress;
  set changeNameInProgress(value) {
    _changeNameInProgress = value;
    notifyListeners();
  }

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

  // VALIDATION
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

  // METHODS

  setUpProfile() async {
    final currentUser = _authenticationService.currentUser();
    currentUserId = currentUser.uid;
    final userData =
        (await _firestoreService.getData("user_info/$currentUserId")).data();

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

  changeName() async {
    if (isFullNameValid && !changeNameInProgress) {
      changeNameInProgress = true;

      try {
        await _firestoreService.setData(
            path: "user_info/$currentUserId",
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
            title: "$currentUserId/profile_",
          );

          await _firestoreService.setData(
            path: "user_info/$currentUserId",
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

  // END PROFILE INFORMATION ---->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>

  // -------------------------------------------------------------------------->

  // START CHANGE PASSWORD ------>>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>

  // METHODS

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

  // END CHANGE PASSWORD -------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>

  // -------------------------------------------------------------------------->

  // START ADDRESS PAGE --------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>

  // PAGE DATA
  String _search = "";
  get search => _search;
  set search(value) {
    _search = value;
    notifyListeners();
  }

  StreamSubscription addressSubscription;
  List<AddressModel> addresses = [];
  List<AddressModel> get filteredAddresses => addresses.where((e) {
        if (search.isNotEmpty) {
          if (e.title.toLowerCase().startsWith(search) ||
              e.description.toLowerCase().startsWith(search)) {
            return true;
          }
        } else {
          return true;
        }

        return false;
      }).toList();

  bool _addressInProgress = false;

  get addressInProgress => _addressInProgress;
  set addressInProgress(value) {
    _addressInProgress = value;
    notifyListeners();
  }

  bool _addressFetched = false;
  get addressFetched => _addressFetched;
  set addressFetched(value) {
    _addressFetched = value;
    notifyListeners();
  }

  // VALIDATION
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

  // METHODS
  addCallbacks() {
    sections[0]["onTap"] = () {
      goToInner("ChangeName");
    };
  }

  setUpAddress() {
    if (!addressFetched) {
      fetchAddress();
    }
  }

  fetchAddress() async {
    final addressSubscription = _firestoreService
        .collectionStream<AddressModel>(
      path: "addresses",
      builder: (data, documentId) =>
          AddressModel.fromMap(data: data, documentId: documentId),
      queryBuilder: (query) => query.where(
        "user_id",
        isEqualTo: _authenticationService.currentUser().uid,
      ),
    )
        .listen((data) {
      addresses = data;
      addressFetched = true;
      notifyListeners();
    });
  }

  addAddress() async {
    if (isAddressValid && !addressInProgress) {
      addressInProgress = true;

      try {
        await _firestoreService.addDocument(path: "addresses", data: {
          "title": addressName.formz.value,
          "description": addressDescription.formz.value,
          "user_id": _authenticationService.currentUser().uid
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

  editAddress({id}) async {
    try {
      await _firestoreService.setData(path: "addresses/$id", data: {
        "title": addressName.formz.value,
        "description": addressDescription.formz.value,
      });

      _overlayService.showSnackBarSuccess(
          widget: Text("Address added successfully"));

      _navigationService.popInner();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  navigateToEditAddress({id, title, description}) {
    goToInner("AddAddress",
        arguments: {"id": id, "title": title, "description": description});
  }

  deleteAddress({id}) async {
    final status = await _overlayService.showYesNoDialog();
    if (status) {
      try {
        await _firestoreService.deleteData("addresses/$id");
      } catch (e) {
        print(e);
      }
    }
  }

  // END ADDRESS PAGE ----------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>

  // -------------------------------------------------------------------------->

  // START PUSH NOT ------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>

  // PAGE DATA
  bool pushNotification = false;

  bool _isTogglePushNotificationInprogress = false;
  get isTogglePushNotificationInprogress => _isTogglePushNotificationInprogress;
  set isTogglePushNotificationInprogress(value) {
    _isTogglePushNotificationInprogress = value;
    notifyListeners();
  }

  // METHODS
  togglePushNotification() async {
    if (!isTogglePushNotificationInprogress) {
      isTogglePushNotificationInprogress = true;

      try {
        final uid = _authenticationService.currentUser().uid;
        await _firestoreService.setData(path: "user_info/$uid", data: {
          "send_push_notifications": !pushNotification,
        });

        pushNotification = !pushNotification;
        notifyListeners();
      } catch (e) {}

      isTogglePushNotificationInprogress = false;
    }
  }

  getPushNotification() async {
    try {
      final uid = _authenticationService.currentUser().uid;
      final snapshot = await _firestoreService.getData("user_info/${uid}");
      final push = snapshot.data()["send_push_notifications"];

      pushNotification = push;
      notifyListeners();

      print(push);
    } catch (e) {
      //
    }
  }

  // END PUSH NOT --------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>
  // ---------------------------->>>

  logOut() async {
    await _authenticationService.logout();
    await _navigationService.navigateToAndClear("SignIn");
  }

  goToProfile() async {
    await _navigationService.navigateInner("Profile");
  }

  goToInner(String route, {arguments}) async {
    await _navigationService.navigateInner(route, arguments: arguments);
  }

  @override
  void dispose() {
    addressSubscription.cancel();
    super.dispose();
  }
}
