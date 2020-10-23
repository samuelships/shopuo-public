import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopuo/Components/BottomNavComponent.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/CartProductCard.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/Input/TextInputComponent.dart';
import 'package:shopuo/Components/PaymentComponent.dart';
import 'package:shopuo/Components/SelectComponent.dart';
import 'package:shopuo/Components/ShippingCard.dart';
import 'package:shopuo/Models/AddressModel.dart';
import 'package:shopuo/Models/CartProductModel.dart';
import 'package:shopuo/Models/DeliveryMethod.dart';
import 'package:shopuo/Models/PaymentModels.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> with TickerProviderStateMixin {
  TabController _controller;
  List<CartProductModel> _cartproducts = cartproducts;

  int _currentShippingAddress = 0;
  List<AddressModel> _shippingAddresses = addresses;

  int _currentDeliveryMethod = 0;
  List<DeliveryMethod> _deliveryMethods = deliveryMethods;

  PaymentMethod _currentPaymentMethod = PaymentMethod.MtnMobileMoney;
  MobileMoneyModel _mobileMoney = MobileMoneyModel();

  CardModel _card = CardModel();

  final chevronDown = "assets/svg_icons/chevron-down.svg";

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: HeaderComponent(
              leading: "assets/svg_icons/chevron-left.svg",
              title: "Cart",
            ),
            body: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Theme(
                    data: ThemeData(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                    child: TabBar(
                      controller: _controller,
                      indicatorColor: MyColor.primaryPurple,
                      indicatorWeight: 5,
                      labelColor: MyColor.primaryPurple,
                      unselectedLabelColor: MyColor.neutralGrey3,
                      labelStyle: MyTypography.body2,
                      onTap: (index) {},
                      tabs: [
                        Tab(
                          text: "CART",
                        ),
                        Tab(
                          text: "CHECKOUT",
                        ),
                        Tab(
                          text: "PAYMENT",
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 500,
                    child: TabBarView(
                      controller: _controller,
                      children: [
                        tabOne(),
                        tabTwo(),
                        tabThree(),
                      ],
                    ),
                  ),
                )
              ],
            ),
            bottomNavigationBar: BottomNavComponent(
              currentIndex: 2,
            ),
          ),
          // DeleteComponent(
          //   dismissCallback: () {
          //     print("dismdissed...");
          //   },
          // )
        ],
      ),
    );
  }

  tabOne() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 25),
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          "Order number is 458765342",
          style: MyTypography.heading5SB.copyWith(color: MyColor.neutralBlack),
        ),
        SizedBox(
          height: 40,
        ),
        ..._cartproducts
            .asMap()
            .map(
              (index, value) => MapEntry(
                index,
                CartProductCard(
                  product: _cartproducts[index],
                ),
              ),
            )
            .values
            .toList(),
        SizedBox(
          height: 50,
        ),
        ..._deliveryMethods
            .asMap()
            .map(
              (index, value) => MapEntry(
                index,
                ShippingCard(
                  callback: (key) {
                    setState(() {
                      _currentDeliveryMethod = key;
                    });
                  },
                  index: index,
                  selected: _currentDeliveryMethod == index ? true : false,
                  primary: _deliveryMethods[index].name,
                  secondary: _deliveryMethods[index].description,
                ),
              ),
            )
            .values
            .toList(),
        SizedBox(
          height: 60,
        ),
        Row(
          children: [
            Text(
              "Order:",
              style: MyTypography.heading6R.copyWith(
                color: MyColor.neutralBlack,
              ),
            ),
            Spacer(),
            Text(
              "\$445.00",
              style: MyTypography.heading6R.copyWith(
                color: MyColor.neutralBlack,
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "Discount:",
              style: MyTypography.heading6R.copyWith(
                color: MyColor.neutralBlack,
              ),
            ),
            Spacer(),
            Text(
              "\$-445.00",
              style: MyTypography.heading6R.copyWith(
                color: MyColor.primaryGreen,
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "Delivery:",
              style: MyTypography.heading6R.copyWith(
                color: MyColor.neutralBlack,
              ),
            ),
            Spacer(),
            Text(
              "\$10.00",
              style: MyTypography.heading6R.copyWith(
                color: MyColor.neutralBlack,
              ),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Text(
              "Total order:",
              style: MyTypography.heading6R.copyWith(
                color: MyColor.neutralBlack,
                fontWeight: FontWeight.w500,
              ),
            ),
            Spacer(),
            Text(
              "\$10.00",
              style: MyTypography.heading6R.copyWith(
                color: MyColor.neutralBlack,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        SizedBox(
          height: 30,
        ),
        ButtonComponent(
          text: "Place order",
          onTap: () {},
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }

  tabTwo() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 25),
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          "Order number is 458765342",
          style: MyTypography.heading5SB.copyWith(
            color: MyColor.neutralBlack,
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Text(
          "Shipping address",
          style: MyTypography.heading5SB.copyWith(
            color: MyColor.neutralBlack,
          ),
        ),
        SizedBox(
          height: 17,
        ),
        ..._shippingAddresses
            .asMap()
            .map(
              (index, value) => MapEntry(
                index,
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _currentShippingAddress = index;
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.only(bottom: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      border: Border.all(
                        color: MyColor.dividerLight,
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 24,
                          width: 24,
                          decoration: BoxDecoration(
                            color: index == _currentShippingAddress
                                ? MyColor.primaryPurple
                                : Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            border: Border.all(
                              color: index == _currentShippingAddress
                                  ? MyColor.primaryPurple
                                  : MyColor.dividerLight,
                            ),
                          ),
                          child: index == _currentShippingAddress
                              ? SvgPicture.asset("assets/svg_icons/check.svg")
                              : Container(),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "${value.title}",
                          style: MyTypography.body1,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
            .values
            .toList(),
        SizedBox(
          height: 30,
        ),
        ButtonComponent(
          text: "Payment Method",
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }

  tabThree() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 25),
      children: [
        SizedBox(
          height: 50,
        ),
        Text(
          "Order number is 458765342",
          style: MyTypography.heading5SB.copyWith(
            color: MyColor.neutralBlack,
          ),
        ),
        SizedBox(
          height: 40,
        ),
        DetailsCard(
            trailing: SelectComponent(
              heading: "Select shipping address",
              onChanged: (key) {
                setState(() {
                  _currentShippingAddress = key;
                });
              },
              options: [
                ..._shippingAddresses.map((e) => e.title),
              ],
              selectedIndex: _currentShippingAddress,
              child: Text(
                "Change",
                style: MyTypography.body2.copyWith(
                  color: MyColor.primaryRed,
                ),
              ),
            ),
            primary: "Shipping address",
            secondary: _shippingAddresses[_currentShippingAddress].description),
        SizedBox(
          height: 20,
        ),
        DetailsCard(
          trailing: SelectComponent(
            selectedIndex: _currentDeliveryMethod,
            heading: "Select delivery type",
            options: [
              ..._deliveryMethods.map((e) => "${e.name} - ${e.description}"),
            ],
            onChanged: (key) {
              setState(() {
                _currentDeliveryMethod = key;
              });
            },
            child: Text(
              "Change",
              style: MyTypography.body2.copyWith(
                color: MyColor.primaryRed,
              ),
            ),
          ),
          primary: "Delivery details",
          secondary:
              "${_deliveryMethods[_currentDeliveryMethod].name} - ${_deliveryMethods[_currentDeliveryMethod].description}",
        ),
        SizedBox(
          height: 70,
        ),
        Text(
          "Select and enter your payment details",
          style: MyTypography.heading6R.copyWith(
            color: MyColor.neutralBlack,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        RichText(
          text: TextSpan(
              text: "By continuing you agree to our ",
              style: MyTypography.smallText,
              children: [
                TextSpan(
                  text: "Terms",
                  style: MyTypography.smallText.copyWith(
                    color: MyColor.primaryPurple,
                  ),
                )
              ]),
        ),
        SizedBox(
          height: 35,
        ),
        SelectPaymentMethodComponent(
          onChange: (PaymentMethod method) {
            setState(() {
              _currentPaymentMethod = method;
            });
          },
        ),
        SizedBox(
          height: 30,
        ),
        if (_currentPaymentMethod == PaymentMethod.Mastercard ||
            _currentPaymentMethod == PaymentMethod.Visa)
          card()
        else
          momo(),
        SizedBox(
          height: 30,
        ),
        ButtonComponent(
          text: "Confirmation",
          onTap: () {},
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

card() {
  return Column(
    children: [
      TextInputComponent(
        hintText: "Tiana Rosser",
      ),
      SizedBox(
        height: 15,
      ),
      TextInputComponent(
        hintText: "**** **** **** 3947",
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        children: [
          Expanded(
            child: TextInputComponent(
              hintText: "05",
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextInputComponent(
              hintText: "2023",
            ),
          )
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        children: [
          Expanded(
            child: TextInputComponent(
              hintText: "123",
              // trailingIcon: chevronDown,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              "3 or 4 digits usually found on the signature strip",
              style: MyTypography.body2.copyWith(
                color: MyColor.neutralGrey3,
              ),
            ),
          )
        ],
      ),
    ],
  );
}

momo() {
  return Column(
    children: [
      TextInputComponent(
        hintText: "Phone Number",
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        children: [
          Expanded(
            child: TextInputComponent(
              hintText: "152658",
              // trailingIcon: chevronDown,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Text(
              "Voucher code for vodafone cash.",
              style: MyTypography.body2.copyWith(
                color: MyColor.neutralGrey3,
              ),
            ),
          )
        ],
      ),
    ],
  );
}

class DetailsCard extends StatelessWidget {
  final primary;
  final secondary;
  final trailing;

  const DetailsCard({
    Key key,
    this.primary,
    this.secondary,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: MyColor.dividerLight,
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  primary,
                  style: MyTypography.heading5SB
                      .copyWith(color: MyColor.neutralBlack),
                ),
                Spacer(),
                if (trailing is String)
                  Text(
                    "Change",
                    style: MyTypography.body2.copyWith(
                      color: MyColor.primaryRed,
                    ),
                  )
                else if (trailing is Widget)
                  trailing
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(secondary)
        ],
      ),
    );
  }
}
