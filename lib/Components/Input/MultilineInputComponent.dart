import "package:flutter/material.dart";
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class MultilineInputComponent extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final error;
  final hintText;
  final obscure;
  final TextEditingController controller;
  final header;
  final TextStyle headerStyle;

  static Color errorColor = Color(0xffFF647C);

  const MultilineInputComponent({
    Key key,
    this.onChanged,
    this.error,
    this.obscure,
    this.controller,
    this.header,
    this.headerStyle,
    @required this.hintText,
  }) : super(key: key);

  @override
  _MultilineInputComponentState createState() =>
      _MultilineInputComponentState();
}

class _MultilineInputComponentState extends State<MultilineInputComponent> {
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
        Text(
          "${widget.header}",
          style: widget.headerStyle ?? MyTypography.heading6SB,
        ),
        SizedBox(
          height: 15,
        ),
        Container(
          height: 140,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: widget.error == null
                  ? MyColor.dividerLight
                  : MultilineInputComponent.errorColor,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: TextField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
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
                  onChanged: widget.onChanged,
                ),
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
              fontSize: 11,
              color: MultilineInputComponent.errorColor,
            ),
          )
        ]
      ],
    );
  }
}
