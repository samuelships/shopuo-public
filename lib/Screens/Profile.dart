import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/SettingsViewModel.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model = Provider.of<SettingsViewModel>(context, listen: false);
      model.setUpModel();
    });
    super.initState();
  }

  SettingsViewModel model;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
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
                      model.fullName,
                      style: MyTypography.heading4R,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.email,
                      style: MyTypography.heading6R,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: model.uploadProfile,
                      child: CachedNetworkImage(
                        imageUrl: model.profile,
                        placeholder: (context, string) => Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: MyColor.primaryPurple,
                          ),
                        ),
                        imageBuilder: (context, imageProvider) => Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.white.withOpacity(.7), width: 2),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
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
                          onTap: item["onTap"],
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["heading"],
                                      style: MyTypography.heading6R.copyWith(
                                        color: MyColor.neutralBlack,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      item["sub heading"],
                                      style: MyTypography.heading6R.copyWith(
                                        color: MyColor.neutralGrey3,
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
