import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final sections = [
    {
      "heading": "Tiana Rosser",
      "sub heading": "Full name",
    },
    {"heading": "Tanamojo@gmail.com", "sub heading": "Email address"},
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                  Align(
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
              height: 40,
            ),
            ...sections
                .map((item) => Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {},
                        splashColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: MyColor.dividerLight))),
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
    );
  }
}
