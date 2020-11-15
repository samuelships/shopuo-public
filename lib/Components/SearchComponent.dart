import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class SearchComponent extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final icon;
  final hintText;
  final TextEditingController controller;

  static Color errorColor = MyColor.primaryRed;

  const SearchComponent({
    Key key,
    this.onChanged,
    this.icon,
    this.controller,
    @required this.hintText,
  }) : super(key: key);

  @override
  _SearchComponentState createState() => _SearchComponentState();
}

class _SearchComponentState extends State<SearchComponent> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    final controller = widget.controller ?? _controller;
    controller.addListener(() {
      if (widget.onChanged != null) {
        widget.onChanged(controller.text);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: MyColor.dividerLight,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                SizedBox(
                  height: 28,
                  width: 28,
                  child: SvgPicture.asset(
                    widget.icon,
                    color: MyColor.neutralBlack,
                  ),
                ),
                SizedBox(
                  width: 15,
                )
              ],
              Expanded(
                child: TextField(
                  controller: widget.controller ?? _controller,
                  style: MyTypography.bodyInput,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(0, 16, 18, 16),
                    isDense: true,
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: MyTypography.bodyInput.copyWith(
                      color: MyColor.neutralGrey3,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
