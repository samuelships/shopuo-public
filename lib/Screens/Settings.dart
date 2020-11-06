import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/SettingsViewModel.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model = Provider.of<SettingsViewModel>(context, listen: false);
    });
    super.initState();
  }

  SettingsViewModel model;

  final sections = [
    {
      "title": "Account settings",
      "items": [
        {
          "icon": "user",
          "heading": "Profile Information",
          "sub heading": "Name, Email",
          "color": Color(0xffA6D6FF),
          "callback": (model) => model.goToProfile()
        },
        {
          "icon": "lock",
          "heading": "Change Password",
          "sub heading": "Change your current password",
          "color": Color(0xff00C48C),
          "callback": (model) => model.goToInner("ChangePassword")
        },
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
  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, model, child) => SafeArea(
        child: Scaffold(
          appBar: HeaderComponent(
            leading: "assets/svg_icons/package.svg",
            title: "Settings",
            trailing: "assets/svg_icons/search.svg",
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 25,
              ),
              ...sections
                  .map(
                    (object) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25),
                          child: Text(
                            object["title"],
                            style: MyTypography.heading5SB.copyWith(
                              color: MyColor.primaryPurple,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        for (Map<String, dynamic> item in object["items"])
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              onTap: item.containsKey("callback")
                                  ? () {
                                      item["callback"](model);
                                    }
                                  : () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom:
                                        BorderSide(color: MyColor.dividerLight),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 25),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 40,
                                        width: 40,
                                        decoration: BoxDecoration(
                                          color: item['color'],
                                          shape: BoxShape.circle,
                                        ),
                                        child: Center(
                                          child: SvgPicture.asset(
                                            "assets/svg_icons/${item['icon']}.svg",
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 17,
                                      ),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item["heading"],
                                              style: MyTypography.heading6SB
                                                  .copyWith(
                                                color: MyColor.neutralBlack,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 3,
                                            ),
                                            Text(
                                              item["sub heading"],
                                              style: MyTypography.bodyInput
                                                  .copyWith(
                                                color: MyColor.neutralGrey3,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  )
                  .toList()
            ],
          ),
        ),
      ),
    );
  }
}

class Section extends StatelessWidget {
  final title;
  final items;

  const Section({Key key, this.title, this.items}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
