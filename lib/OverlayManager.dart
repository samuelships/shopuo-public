import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/DeleteComponent.dart';
import 'package:shopuo/Components/LoadingComponent2.dart';
import 'package:shopuo/Components/PaymentInstructionsComponent.dart';
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
    overlayService.registerPaymentDialogCallback(showPaymentDialog);
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
    setState(() {
      _showLoadingDialog = false;
    });
  }

  // PAYMENT INSTRUCTIONS DIALOG
  bool _showPaymentDialog = false;

  showPaymentDialog() {
    setState(() {
      _showPaymentDialog = true;
    });
  }

  hidePaymentDialog() {
    setState(() {
      _showPaymentDialog = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: overlayService.scaffoldKey,
        body: Stack(
          fit: StackFit.expand,
          children: [
            widget.child,
            if (_showPaymentDialog)
              PaymentInstructionsComponent(
                onOkay: () {
                  overlayService.showPaymentDialogCompleter.complete(true);
                  hidePaymentDialog();
                  overlayService.showPaymentDialogCompleter = null;
                },
                dismissCallback: () {
                  overlayService.showPaymentDialogCompleter.complete(false);
                  hidePaymentDialog();
                  overlayService.showPaymentDialogCompleter = null;
                },
              ),
            if (_showLoadingDialog)
              LoadingComponent2(
                dismissCallback: () {
                  overlayService.showLoadingDialogCompleter.complete(false);
                  hideLoadingDialog();
                  overlayService.showLoadingDialogCompleter = null;
                },
                onCancel: () {
                  overlayService.showLoadingDialogCompleter.complete(true);
                  hideLoadingDialog();
                  overlayService.showLoadingDialogCompleter = null;
                },
              ),
            if (_showYesNoDialog)
              DeleteComponent(
                dismissCallback: hideYesNoDialog,
                onYes: () {
                  overlayService.yesNoDialogCompleter.complete(true);
                  hideYesNoDialog();
                  overlayService.yesNoDialogCompleter = null;
                },
                onNo: () {
                  overlayService.yesNoDialogCompleter.complete(false);
                  hideYesNoDialog();
                  overlayService.yesNoDialogCompleter = null;
                },
              )
          ],
        ),
      ),
    );
  }
}
