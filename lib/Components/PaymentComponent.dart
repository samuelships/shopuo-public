import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shopuo/Models/PaymentModels.dart';
import 'package:shopuo/Styles/Color.dart';

class SelectPaymentMethodComponent extends StatefulWidget {
  final Function(PaymentMethod index) onChange;
  final PaymentMethod currentPaymentMethod;

  const SelectPaymentMethodComponent({
    Key key,
    this.onChange,
    this.currentPaymentMethod = PaymentMethod.MtnMobileMoney,
  })  : assert(onChange != null),
        super(key: key);

  @override
  _SelectPaymentMethodComponentState createState() =>
      _SelectPaymentMethodComponentState();
}

class _SelectPaymentMethodComponentState
    extends State<SelectPaymentMethodComponent> {
  PaymentMethod currentPaymentMethod;

  List<String> _paymentMethods = [
    "assets/svg_icons/mtn.svg",
    "assets/svg_icons/vodafone.svg",
    "assets/svg_icons/airteltigo.svg",
    "assets/svg_icons/visa.svg",
    "assets/svg_icons/mastercard.svg",
  ];

  @override
  void initState() {
    currentPaymentMethod = widget.currentPaymentMethod;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ..._paymentMethods
            .asMap()
            .map(
              (index, value) => MapEntry(
                index,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      currentPaymentMethod = PaymentMethod.values[index];
                      widget.onChange(currentPaymentMethod);
                    });
                  },
                  child: Container(
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          width: currentPaymentMethod.index == index ? 70 : 48,
                          height: currentPaymentMethod.index == index ? 70 : 48,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            border: Border.all(
                              color: MyColor.dividerLight,
                            ),
                          ),
                          child: currentPaymentMethod.index == index
                              ? FittedBox(
                                  child: Center(
                                    child: SvgPicture.asset(
                                      value,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: SvgPicture.asset(
                                    value,
                                  ),
                                ),
                        ),
                        if (currentPaymentMethod.index == index)
                          Positioned(
                            bottom: -10,
                            right: -10,
                            child: Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                  width: 4,
                                ),
                                shape: BoxShape.circle,
                                color: MyColor.primaryGreen,
                              ),
                              child: SvgPicture.asset(
                                "assets/svg_icons/check.svg",
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            )
            .values
            .toList()
      ],
    );
  }
}
