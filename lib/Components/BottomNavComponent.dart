import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class BottomNavComponent extends StatelessWidget {
  final currentIndex;
  final List<List<String>> icons = [
    ["assets/svg_icons/home.svg", "On Sale"],
    ["assets/svg_icons/layers.svg", "Categories"],
    ["assets/svg_icons/shopping-bag.svg", "Cart"],
    ["assets/svg_icons/settings.svg", "Settings"]
  ];

  BottomNavComponent({Key key, @required this.currentIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRect(
        child: BackdropFilter(
      filter: ImageFilter.blur(
        sigmaX: 5.0,
        sigmaY: 5.0,
      ),
      child: Container(
          height: 82,
          decoration: BoxDecoration(
            color: Color(0xffF8F8F8).withOpacity(.92),
          ),
          child: Column(
            children: [
              Container(
                height: 1,
                color: Color(0xffC7C7C7),
              ),
              SizedBox(
                height: 8,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ...icons
                        .asMap()
                        .map((index, value) => MapEntry(
                              index,
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    "${value[0]}",
                                    color: currentIndex == index
                                        ? MyColor.primaryPurple
                                        : MyColor.neutralGrey3,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "${value[1]}",
                                    style: MyTypography.smallText.copyWith(
                                      color: currentIndex == index
                                          ? MyColor.primaryPurple
                                          : MyColor.neutralGrey3,
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .values
                        .toList()
                  ],
                ),
              ),
            ],
          )),
    ));
  }
}
