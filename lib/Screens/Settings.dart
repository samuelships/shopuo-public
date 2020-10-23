import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Components/BottomNavComponent.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final sections = [
    {
      "title": "Account settings",
      "items": [
        {
          "icon": "user",
          "heading": "Profile Information",
          "sub heading": "Name, Email",
          "color": Color(0xffA6D6FF)
        },
        {
          "icon": "lock",
          "heading": "Change Password",
          "sub heading": "Change your current password",
          "color": Color(0xff00C48C)
        },
        {
          "icon": "map-pin",
          "heading": "Add Addresses",
          "sub heading": "Add your shipping addresses",
          "color": Color(0xff00C48C)
        }
      ]
    },
    {
      "title": "Notifications settings",
      "items": [
        {
          "icon": "bell",
          "heading": "Push Notifications",
          "sub heading": "Turn on and off push notifications",
          "color": Color(0xffFF98A8)
        }
      ]
    },
    {
      "title": "General",
      "items": [
        {
          "icon": "heart",
          "heading": "Rate our App",
          "sub heading": "Rate & review us",
          "color": Color(0xffF6BB86)
        },
        {
          "icon": "mail",
          "heading": "Send Feedback",
          "sub heading": "Share your thought",
          "color": Color(0xffFFDF92)
        },
        {
          "icon": "eye-off",
          "heading": "Privacy Policy",
          "sub heading": "Review our privacy policy",
          "color": Color(0xff96FFE1)
        }
      ]
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                      for (var item in object["items"])
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {},
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                            style:
                                                MyTypography.bodyInput.copyWith(
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
        bottomNavigationBar: BottomNavComponent(
          currentIndex: 3,
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
