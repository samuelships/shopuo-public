import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:shopuo/Services/OverlayService.dart';

import '../locator.dart';

class OverlayManagerViewModel with ChangeNotifier {
  // services
  final overrlayService = locator<OverlayService>();

  // other variables
  StreamSubscription listener;
  int value = 0;

  // methods
  setUpModel() {
    handleConnection();
  }

  handleConnection() {
    final connection = DataConnectionChecker();
    connection.checkInterval = Duration(seconds: 1);
    listener = connection.onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          if (value != 0) {
            // print("internet is working");
            overrlayService.scaffoldKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text("Internet connection is available"),
            ));
          }
          value = 1;

          break;
        case DataConnectionStatus.disconnected:
          if (value != 0) {
            // print("internet is not working");
            overrlayService.scaffoldKey.currentState.showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text("Internet connection is not available"),
            ));
          }
          value = 1;

          break;
      }
    });
  }

  @override
  void dispose() {
    listener.cancel();
    super.dispose();
  }
}
