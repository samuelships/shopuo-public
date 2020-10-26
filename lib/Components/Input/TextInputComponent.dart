import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class TextInputComponent extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final error;
  final hintText;
  final trailingIcon;
  final obscure;
  final TextEditingController controller;
  final header;
  final TextStyle headerStyle;

  const TextInputComponent({
    Key key,
    this.onChanged,
    this.error,
    this.obscure,
    this.controller,
    this.header,
    this.headerStyle,
    @required this.hintText,
    this.trailingIcon,
  }) : super(key: key);

  @override
  _TextInputComponentState createState() => _TextInputComponentState();
}

class _TextInputComponentState extends State<TextInputComponent> {
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
        if (widget.header != null) ...[
          Text(
            "${widget.header}",
            style: widget.headerStyle ?? MyTypography.heading6SB,
          ),
          SizedBox(
            height: 15,
          )
        ],
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: widget.error == null
                  ? MyColor.dividerLight
                  : MyColor.primaryRed,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller ?? _controller,
                  style: TextStyle(
                    fontFamily: "SF Pro Display",
                    color: widget.error == null
                        ? MyColor.neutralBlack
                        : MyColor.primaryRed,
                    fontSize: 13,
                  ),
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    isDense: true,
                    border: InputBorder.none,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      fontFamily: "SF Pro Display",
                      color: widget.error == null
                          ? MyColor.neutralBlack
                          : MyColor.primaryRed,
                      fontSize: 13,
                    ),
                  ),
                  obscureText: widget.obscure == true ? true : false,
                ),
              ),
              if (widget.trailingIcon != null)
                Transform.translate(
                  offset: Offset(-10, 0),
                  child: SvgPicture.asset(widget.trailingIcon),
                )
            ],
          ),
        ),
        if (widget.error != null) ...[
          SizedBox(
            height: 5,
          ),
          Text(
            "${widget.error}",
            style: TextStyle(
              fontFamily: "SF Pro Display",
              fontSize: MyTypography.body1.fontSize,
              color: MyColor.primaryRed,
            ),
          )
        ]
      ],
    );
  }
}
