import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/DeleteComponent.dart';
import 'package:shopuo/Components/LoadingComponent2.dart';
import 'package:shopuo/Components/OkayDialogComponent.dart';
import 'package:shopuo/Services/OverlayService.dart';
import "./ViewModels/OverlayManagerViewModel.dart";
import 'Services/FirebaseMessagingService.dart';
import 'locator.dart';

class OverlayManager extends StatefulWidget {
  final Widget child;

  static Widget create({child}) {
    return ChangeNotifierProvider<OverlayManagerViewModel>(
      create: (_) => locator<OverlayManagerViewModel>(),
      child: OverlayManager(
        child: child,
      ),
    );
  }

  const OverlayManager({Key key, this.child}) : super(key: key);
  @override
  _OverlayManagerState createState() => _OverlayManagerState();
}

class _OverlayManagerState extends State<OverlayManager> {
  @override
  void initState() {
    firebaseMessagingService.register();
    overlayService.registerYesNoDialogCallback(showYesNoDialog);
    overlayService.registerLoadingDialogCallback(showLoadingDialog);
    overlayService.registerHideLoadingDialogCallback(hideLoadingDialog);
    overlayService.registerHideOkayDialogCallback(hideOkayDialog);
    overlayService.registerOkayDialogCallback(showOkayDialog);
    WidgetsBinding.instance.addPostFrameCallback((_) => setUpModel(context));
    super.initState();
  }

  setUpModel(context) {
    final model = Provider.of<OverlayManagerViewModel>(context, listen: false);
    model.setUpModel();
  }

  final overlayService = locator<OverlayService>();
  final FirebaseMessagingService firebaseMessagingService =
      locator<FirebaseMessagingService>();

  // SHOW YES DIALOG
  bool _showYesNoDialog = false;

  showYesNoDialog() {
    setState(() {
      _showYesNoDialog = true;
    });
  }

  hideYesNoDialog() {
    setState(() {
      _showYesNoDialog = false;
    });
  }

  // LOADING DIALOG
  bool _showLoadingDialog = false;

  showLoadingDialog() {
    setState(() {
      _showLoadingDialog = true;
    });
  }

  hideLoadingDialog() {
    if (overlayService.showLoadingDialogCompleter != null) {
      overlayService.showLoadingDialogCompleter.complete(false);
      overlayService.showLoadingDialogCompleter = null;
    }
    setState(() {
      _showLoadingDialog = false;
    });
  }

  // OKAY  DIALOG
  String icon = "assets/svg_icons/monthly-salary.svg";
  String primary = "Payment Instructions";
  String secondary =
      "You would be redirected and a push notification will been sent to your phone, do you like to continue?";

  bool _showOkayDialog = false;

  showOkayDialog({icon, primary, secondary}) {
    if (icon != null) {
      setState(() {
        this.icon = icon;
      });
    }

    if (primary != null) {
      setState(() {
        this.primary = primary;
      });
    }

    if (secondary != null) {
      setState(() {
        this.secondary = secondary;
      });
    }

    setState(() {
      _showOkayDialog = true;
    });
  }

  hideOkayDialog() {
    if (overlayService.showOkayDialogCompleter != null) {
      print("loading dialog is not null");
      overlayService.showOkayDialogCompleter.complete(false);
      overlayService.showOkayDialogCompleter = null;
    }

    setState(() {
      _showOkayDialog = false;
      icon = "assets/svg_icons/monthly-salary.svg";
      primary = "Payment Instructions";
      secondary =
          "You would be redirected and a push notification will been sent to your phone, do you like to continue?";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        key: overlayService.scaffoldKey,
        body: Stack(
          fit: StackFit.expand,
          children: [
            widget.child,
            if (_showOkayDialog)
              OkayDialogComponent(
                icon: icon,
                primary: primary,
                secondary: secondary,
                onOkay: () {
                  overlayService.showOkayDialogCompleter.complete(true);
                  overlayService.showOkayDialogCompleter = null;
                  hideOkayDialog();
                },
                dismissCallback: () {
                  overlayService.showOkayDialogCompleter.complete(false);
                  overlayService.showOkayDialogCompleter = null;
                  hideOkayDialog();
                },
              ),
            if (_showLoadingDialog)
              LoadingComponent2(
                dismissCallback: () {
                  overlayService.showLoadingDialogCompleter.complete(false);
                  overlayService.showLoadingDialogCompleter = null;
                  hideLoadingDialog();
                },
                onCancel: () {
                  overlayService.showLoadingDialogCompleter.complete(true);
                  overlayService.showLoadingDialogCompleter = null;
                  hideLoadingDialog();
                },
              ),
            if (_showYesNoDialog)
              DeleteComponent(
                dismissCallback: hideYesNoDialog,
                onYes: () {
                  overlayService.yesNoDialogCompleter.complete(true);
                  overlayService.yesNoDialogCompleter = null;
                  hideYesNoDialog();
                },
                onNo: () {
                  overlayService.yesNoDialogCompleter.complete(false);
                  overlayService.yesNoDialogCompleter = null;
                  hideYesNoDialog();
                },
              )
          ],
        ),
      ),
    );
  }
}
