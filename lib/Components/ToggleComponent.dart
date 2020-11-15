import "package:flutter/material.dart";

class ToggleComponent extends StatelessWidget {
  final color;
  final position;
  final Function onTap;

  const ToggleComponent({Key key, this.color, this.position, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 28,
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
                color: Color(0xff323247).withOpacity(.08),
                offset: Offset(0, 8),
                blurRadius: 4),
            BoxShadow(
              color: Color(0xff323247).withOpacity(.08),
              offset: Offset(0, 8),
              blurRadius: 8,
            )
          ],
        ),
        child: Row(
          mainAxisAlignment:
              position ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(50),
              ),
            )
          ],
        ),
      ),
    );
  }
}
