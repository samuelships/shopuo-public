import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/ProfileViewModel.dart';

import '../locator.dart';

class Profile extends StatefulWidget {
  static Widget create() {
    return ChangeNotifierProvider<ProfileViewModel>(
      create: (_) => locator<ProfileViewModel>(),
      child: Profile(),
    );
  }

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model = Provider.of<ProfileViewModel>(context, listen: false);
      model.setUpModel();
    });
    super.initState();
  }

  ProfileViewModel model;

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          body: ListView(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 20),
                color: MyColor.primaryPurple1,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: Navigator.of(context).pop,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Transform.translate(
                          offset: Offset(10, 0),
                          child: Container(
                            child: SvgPicture.asset(
                              "assets/svg_icons/chevron-left.svg",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Tana Mojo",
                      style: MyTypography.heading4R,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "tanamojo@gmail.com",
                      style: MyTypography.heading6R,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage("assets/images/profile.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              ...model.sections
                  .map((item) => Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {},
                          splashColor: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: MyColor.dividerLight))),
                            padding: EdgeInsets.symmetric(
                              horizontal: 25,
                              vertical: 25,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      item["heading"],
                                      style: MyTypography.heading6R.copyWith(
                                        color: MyColor.neutralBlack,
                                      ),
                                    )
                                  ],
                                ),
                                SvgPicture.asset(
                                  "assets/svg_icons/chevron-right.svg",
                                  color: MyColor.neutralGrey3,
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}
