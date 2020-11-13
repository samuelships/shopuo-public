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
          appBar: HeaderComponent(
            leading: "assets/svg_icons/package.svg",
            title: "Settings",
            leadingCallback: () {
              model.navigateToOrders();
            },
            //trailing: "assets/svg_icons/search.svg",
          ),
          body: ListView(
            children: [
              SizedBox(
                height: 25,
              ),
              ...model.settingsSections
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
