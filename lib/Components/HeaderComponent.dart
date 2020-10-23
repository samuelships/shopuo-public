import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class HeaderComponent extends StatelessWidget implements PreferredSizeWidget {
  final leading;
  final title;
  final trailing;
  final background;
  final leadingColor;
  final titleStyle;

  HeaderComponent({
    Key key,
    this.leading,
    this.title,
    this.trailing,
    this.background,
    this.leadingColor,
    this.titleStyle,
  })  : assert(leading != null),
        assert(title != null),
        super(key: key);

  static final fontStyle = MyTypography.heading5SB.copyWith(
    color: MyColor.neutralBlack,
  );

  @override
  final Size preferredSize = Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background ?? Colors.white,
        border: Border(
          bottom: BorderSide(color: MyColor.dividerLight),
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Transform.translate(
                offset: Offset(-10, 0),
                child: SvgPicture.asset(
                  "$leading",
                  height: 28,
                  width: 28,
                  color: leadingColor ?? MyColor.neutralBlack,
                ),
              ),
              Text(
                "$title",
                style: titleStyle ?? HeaderComponent.fontStyle,
              ),
              Transform.translate(
                offset: Offset(10, 0),
                child: trailing != null
                    ? SvgPicture.asset(
                        "$trailing",
                        height: 28,
                        width: 28,
                        color: MyColor.neutralBlack,
                      )
                    : SizedBox(
                        height: 28,
                        width: 28,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
