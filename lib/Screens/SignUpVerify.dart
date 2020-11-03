import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/SignUpVerifyViewModel.dart';

import '../locator.dart';

class SignUpVerify extends StatefulWidget {
  const SignUpVerify({Key key, this.phoneNumber = "05xxxxxxx"})
      : super(key: key);

  static Widget create({phoneNumber}) {
    return ChangeNotifierProvider<SignUpVerifyViewModel>(
      create: (_) => locator<SignUpVerifyViewModel>(),
      child: SignUpVerify(phoneNumber: phoneNumber),
    );
  }

  final phoneNumber;

  @override
  _SignUpVerifyState createState() => _SignUpVerifyState();
}

class _SignUpVerifyState extends State<SignUpVerify> {
  final TextEditingController _pinPutController = TextEditingController();
  final FocusNode _pinPutFocusNode = FocusNode();
  SignUpVerifyViewModel model;
  bool validated = false;
  String code;

  TextStyle resendStyle = TextStyle(
    fontSize: 15,
    fontFamily: "SF Pro Display",
    color: Color(0xff6979F8),
  );

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(
        color: Color(0xffE4E4E4),
      ),
      borderRadius: BorderRadius.circular(10),
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model = Provider.of<SignUpVerifyViewModel>(context, listen: false);
      model.setUp();
    });
    super.initState();
  }

  @override
  void dispose() {
    _pinPutController.dispose();
    _pinPutFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SignUpVerifyViewModel>(
      builder: (context, model, child) => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: HeaderComponent(
          leading: "assets/svg_icons/chevron-left.svg",
          leadingCallback: Navigator.of(context).pop,
        ),
        body: Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(horizontal: 25),
              children: [
                SizedBox(
                  height: 50,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 148,
                    child: Text(
                      "Verification code",
                      style: MyTypography.heading2SB.copyWith(
                        color: MyColor.neutralBlack,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    width: 325,
                    child: Text(
                      "Verify your account by entering the 4 digits code sent to: ${widget.phoneNumber}",
                      style: MyTypography.heading5L.copyWith(
                        color: MyColor.neutralGrey3,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                PinPut(
                  fieldsCount: 4,
                  eachFieldWidth: 60,
                  eachFieldHeight: 60,
                  textStyle: TextStyle(
                    fontFamily: "SF Pro Display",
                    fontSize: 20,
                    color: Color(0xff151522),
                  ),
                  onSubmit: (String pin) async {
                    code = pin;
                  },
                  onChanged: (value) {
                    if (value.length != 4) {
                      validated = false;
                    } else {
                      validated = true;
                    }
                  },
                  focusNode: _pinPutFocusNode,
                  controller: _pinPutController,
                  submittedFieldDecoration: _pinPutDecoration,
                  selectedFieldDecoration: _pinPutDecoration.copyWith(
                    border: Border.all(
                      color: MyColor.primaryPurple,
                    ),
                  ),
                  followingFieldDecoration: _pinPutDecoration,
                )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                child: Column(
                  children: [
                    ButtonComponent(
                      text: "Next",
                      active: !model.isVerifyPhoneNumberInProgress,
                      onTap: () {
                        if (validated) {
                          model.verifyPhoneNumber(code);
                        }
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (model.isTimeToSend)
                      GestureDetector(
                        onTap: model.resendCode,
                        child: Text(
                          "Resend code",
                          style: MyTypography.heading6R.copyWith(
                            color: MyColor.primaryPurple,
                          ),
                        ),
                      )
                    else
                      CountdownTimer(
                        endTime: model.timeToSend,
                        textStyle: resendStyle,
                        widgetBuilder: (_, CurrentRemainingTime time) {
                          final minute = time.min == null ? "" : "${time.min}:";
                          final timer = "$minute${time.sec}";
                          return Text(
                            "Resend code in $timer",
                            style: MyTypography.heading6R.copyWith(
                              color: MyColor.neutralGrey3,
                            ),
                          );
                        },
                        onEnd: () {
                          model.isTimeToSend = true;
                        },
                      )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
