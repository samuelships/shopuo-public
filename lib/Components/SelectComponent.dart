import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

import '../ModalBottomSheetInspection.dart';

class SelectComponent extends StatefulWidget {
  final Widget child;
  final Function onChanged;
  final List<String> options;
  final int selectedIndex;
  final String heading;

  const SelectComponent({
    Key key,
    this.child,
    this.onChanged,
    this.options,
    this.selectedIndex,
    this.heading,
  })  : assert(child != null),
        assert(onChanged != null),
        super(key: key);
  @override
  _SelectComponentState createState() => _SelectComponentState();
}

class _SelectComponentState extends State<SelectComponent> {
  int selectedIndex;

  Future<String> showAlert() async {
    return await showModalBottomSheetMine<String>(
      isScrollControlled: true,
      context: context,
      builder: (context) => Container(
        height: 100 + (widget.options.length.toDouble() * 50),
        child: StatefulBuilder(
          builder: (context, newState) {
            newState(() {
              selectedIndex = widget.selectedIndex;
            });

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5,
                ),
                Center(
                  child: Container(
                    width: 50,
                    height: 5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyColor.neutralGrey4,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 25,
                  ),
                  child: Text(
                    widget.heading,
                    style: MyTypography.heading5SB.copyWith(
                      color: MyColor.neutralBlack,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                ...widget.options
                    .asMap()
                    .map(
                      (key, value) => MapEntry(
                        key,
                        buildOption(
                          text: widget.options[key],
                          key: key,
                          selected: key == widget.selectedIndex,
                          newState: newState,
                        ),
                      ),
                    )
                    .values
                    .toList()
              ],
            );
          },
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Widget buildOption({selected, text, key, newState}) {
    return Material(
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () {
          widget.onChanged(key);
          newState(() {
            selectedIndex = key;
          });
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: MyTypography.heading6R.copyWith(
                  color: MyColor.neutralBlack,
                ),
              ),
              if (selectedIndex == key)
                SvgPicture.asset(
                  "assets/svg_icons/check.svg",
                  color: MyColor.neutralBlack,
                )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showAlert();
      },
      child: widget.child,
    );
  }
}
