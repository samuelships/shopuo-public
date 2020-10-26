import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/EntryPointViewModel.dart';
import 'package:shopuo/locator.dart';

class EntryPoint extends StatefulWidget {
  static Widget create() {
    return ChangeNotifierProvider<EntryPointViewModel>(
      create: (_) => locator<EntryPointViewModel>(),
      builder: (_, __) => EntryPoint(),
    );
  }

  @override
  _EntryPointState createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var model = Provider.of<EntryPointViewModel>(context, listen: false);
      await Future.delayed(Duration(milliseconds: 1000));
      model.setUpModel();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "shopuo.",
        style: MyTypography.heading2SB.copyWith(
          color: MyColor.neutralBlack,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
