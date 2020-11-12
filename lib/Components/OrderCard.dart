import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Models/OrderModel.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrderCard extends StatefulWidget {
  final OrderModel order;

  const OrderCard({Key key, this.order}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isHidden = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: MyColor.dividerLight),
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 16),
            blurRadius: 16,
            color: Color(0xff323247).withOpacity(.08),
          ),
          BoxShadow(
            offset: Offset(0, 24),
            blurRadius: 32,
            color: Color(0xff323247).withOpacity(.08),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionOne(),
          sectionTwo(),
          sectionThree(),
          sectionFour(),
        ],
      ),
    );
  }

  sectionOne() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: MyColor.dividerLight,
          ),
        ),
      ),
      child: Row(
        children: [
          widget.order.status == OrderStatus.inProgress
              ? SvgPicture.asset(
                  "assets/svg_icons/clock.svg",
                  color: MyColor.primarySunflower,
                )
              : widget.order.status == OrderStatus.delivered
                  ? SvgPicture.asset(
                      "assets/svg_icons/check.svg",
                      color: MyColor.primaryGreen,
                    )
                  : SvgPicture.asset(
                      "assets/svg_icons/more-horizontal.svg",
                      color: MyColor.primaryBlue,
                    ),
          SizedBox(
            width: 10,
          ),
          widget.order.status == OrderStatus.inProgress
              ? Text(
                  "IN PROGRESS",
                  style: MyTypography.smallText.copyWith(
                    color: MyColor.primarySunflower,
                  ),
                )
              : widget.order.status == OrderStatus.delivered
                  ? Text(
                      "DELIVERD",
                      style: MyTypography.smallText.copyWith(
                        color: MyColor.primaryGreen,
                      ),
                    )
                  : Text(
                      "WAITING",
                      style: MyTypography.smallText.copyWith(
                        color: MyColor.primaryBlue,
                      ),
                    ),
          Spacer(),
          Text(
            "${timeago.format(DateTime.parse(widget.order.timeOrdered))}",
            style: MyTypography.bodyInput.copyWith(
              color: MyColor.neutralGrey3,
            ),
          )
        ],
      ),
    );
  }

  sectionTwo() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: MyColor.dividerLight,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Order № ${widget.order.trackingNumber}",
            style: MyTypography.heading4SB.copyWith(
              color: MyColor.primaryPurple,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          RichText(
            text: TextSpan(
              text: "Tracking number:     ",
              style: MyTypography.body2.copyWith(color: MyColor.neutralGrey3),
              children: [
                TextSpan(
                  text: widget.order.trackingNumber,
                  style: MyTypography.body2.copyWith(
                    color: MyColor.primaryPurple2,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  sectionThree() {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: MyColor.dividerLight,
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "VALUE OF ITEMS",
                style: MyTypography.smallText.copyWith(
                  color: MyColor.neutralGrey3,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "\$ ${widget.order.valueOfItems}",
                style: MyTypography.heading6R.copyWith(
                  color: MyColor.neutralBlack,
                ),
              )
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "QUANTITY",
                style: MyTypography.smallText.copyWith(
                  color: MyColor.neutralGrey3,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                " ${widget.order.quantity} items",
                style: MyTypography.heading6R.copyWith(
                  color: MyColor.neutralBlack,
                ),
              )
            ],
          ),
          Spacer()
        ],
      ),
    );
  }

  sectionFour() {
    return Container(
      // decoration: BoxDecoration(
      //   border: Border(
      //     bottom: BorderSide(
      //       color: MyColor.dividerLight,
      //     ),
      //   ),
      // ),
      padding: EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 15,
      ),
      margin: EdgeInsets.only(bottom: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SHIPPIGN PROGRESS",
            style: MyTypography.base.copyWith(
              fontSize: 12,
              color: MyColor.neutralBlack,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SvgPicture.asset("assets/svg_icons/truck.svg"),
              SizedBox(
                width: 10,
              ),
              RichText(
                text: TextSpan(
                  text: "${widget.order.progressText} ",
                  style: MyTypography.heading6SB.copyWith(
                    color: MyColor.neutralBlack,
                  ),
                  children: [
                    TextSpan(
                      text: "- ${widget.order.shippingPlan}",
                      style: MyTypography.body2.copyWith(
                        color: MyColor.neutralGrey3,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int item in List(widget.order.progress)) ...[
                buildBar(isActive: true),
                Spacer(),
              ],
              for (int item in List(4 - widget.order.progress)) ...[
                buildBar(isActive: false),
                Spacer(),
              ],
              Spacer(
                flex: 10,
              )
            ],
          )
        ],
      ),
    );
  }

  buildBar({isActive}) {
    return Container(
      height: 2,
      color: isActive ? MyColor.primaryPurple : MyColor.primaryPurple2,
      width: 50,
    );
  }
}
