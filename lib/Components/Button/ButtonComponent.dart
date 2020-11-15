import "package:flutter/material.dart";
import 'package:flutter_svg/svg.dart';
import 'package:shopuo/Styles/Color.dart';

class ButtonComponent extends StatelessWidget {
  final text;
  final color;
  final textColor;
  final icon;
  final active;
  final Function onTap;

  Color get buttonColor {
    if (active)
      return color ?? MyColor.primaryPurple;
    else
      return color?.withOpacity(.7) ?? MyColor.primaryPurple.withOpacity(.7);
  }

  ButtonComponent({
    Key key,
    this.text,
    this.color,
    this.textColor,
    this.icon,
    this.active: true,
    this.onTap,
  })  : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 4),
            color: Color(0xff323247).withOpacity(.08),
          ),
          BoxShadow(
            blurRadius: 4,
            offset: Offset(0, 4),
            color: Color(0xff323247).withOpacity(.08),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        color: Colors.transparent,
        shadowColor: Colors.yellow,
        child: InkWell(
          splashColor: Colors.white30,
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 14, horizontal: 10),
            child: Row(
              mainAxisAlignment: icon == null
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                if (icon != null) ...[
                  SvgPicture.asset(
                    icon,
                    color: Colors.white,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 1,
                    height: 20,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 50,
                  ),
                ],
                Text(
                  text,
                  style: TextStyle(
                    color: textColor == null ? Colors.white : textColor,
                    fontFamily: "SF Pro Display",
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
