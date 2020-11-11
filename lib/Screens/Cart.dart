import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/CartProductCard.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Components/Input/TextInputComponent.dart';
import 'package:shopuo/Components/PaymentComponent.dart';
import 'package:shopuo/Components/SelectComponent.dart';
import 'package:shopuo/Components/ShippingCard.dart';
import 'package:shopuo/Models/PaymentModels.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/CartViewModel.dart';
import 'package:shopuo/ViewModels/SettingsViewModel.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> with TickerProviderStateMixin {
  TabController _controller;

  final chevronDown = "assets/svg_icons/chevron-down.svg";

  @override
  void initState() {
    _controller = TabController(length: 3, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      model = Provider.of<CartViewModel>(context, listen: false);
      model.setUpModel();
    });
    super.initState();
  }

  CartViewModel model;

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context2, model2, child2) => Consumer<CartViewModel>(
        builder: (context, CartViewModel model, child) => SafeArea(
          child: Stack(
            children: [
              if (!model.modelReady)
                Text("Loading...")
              else
                Scaffold(
                  appBar: HeaderComponent(
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
                              tabOne(model, model2),
                              tabTwo(model, model2),
                              tabThree(model, model2),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  tabOne(CartViewModel model, SettingsViewModel model2) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 25),
      children: [
        SizedBox(
          height: 40,
        ),
        ...model.cartproducts
            .asMap()
            .map(
              (index, value) => MapEntry(
                index,
                CartProductCard(
                  onDelete: () {
                    model.deleteCartItem(id: model.cartproducts[index].id);
                  },
                  product: model.cartproducts[index],
                ),
              ),
            )
            .values
            .toList(),
        SizedBox(
          height: 50,
        ),
        ...model.deliveryMethods
            .asMap()
            .map(
              (index, value) => MapEntry(
                index,
                ShippingCard(
                  callback: (key) {
                    model.currentDeliveryMethod = key;
                  },
                  index: index,
                  selected: model.currentDeliveryMethod == index ? true : false,
                  primary: model.deliveryMethods[index].name,
                  secondary: "\$${model.deliveryMethods[index].price}",
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
              "\$${model.orderAmount}",
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
              "Delivery:",
              style: MyTypography.heading6R.copyWith(
                color: MyColor.neutralBlack,
              ),
            ),
            Spacer(),
            Text(
              "\$${model.deliveryAmount}",
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
              "\$${model.totalAmount}",
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

  tabTwo(CartViewModel model, SettingsViewModel model2) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 25),
      children: [
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
        ...model2.addresses
            .asMap()
            .map(
              (index, value) => MapEntry(
                index,
                GestureDetector(
                  onTap: () {
                    model.currentShippingAddress = index;
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
                            color: index == model.currentShippingAddress
                                ? MyColor.primaryPurple
                                : Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                            border: Border.all(
                              color: index == model.currentShippingAddress
                                  ? MyColor.primaryPurple
                                  : MyColor.dividerLight,
                            ),
                          ),
                          child: index == model.currentShippingAddress
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

  tabThree(CartViewModel model, SettingsViewModel model2) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 25),
      children: [
        SizedBox(
          height: 40,
        ),
        DetailsCard(
          trailing: SelectComponent(
            heading: "Select shipping address",
            onChanged: (key) {
              model.currentShippingAddress = key;
            },
            options: [
              ...model2.addresses.map((e) => e.title),
            ],
            selectedIndex: model.currentShippingAddress,
            child: Text(
              "Change",
              style: MyTypography.body2.copyWith(
                color: MyColor.primaryRed,
              ),
            ),
          ),
          primary: "Shipping address",
          secondary: model2.addresses[model.currentShippingAddress].description,
        ),
        SizedBox(
          height: 20,
        ),
        DetailsCard(
          trailing: SelectComponent(
            selectedIndex: model.currentDeliveryMethod,
            heading: "Select delivery type",
            options: [
              ...model.deliveryMethods.map((e) => "${e.name} - ${e.price}"),
            ],
            onChanged: (key) {
              model.currentDeliveryMethod = key;
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
              "${model.deliveryMethods[model.currentDeliveryMethod].name} - ${model.deliveryMethods[model.currentDeliveryMethod].price}",
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
            model.currentPaymentMethod = method;
          },
        ),
        SizedBox(
          height: 30,
        ),
        if (model.currentPaymentMethod == PaymentMethod.Mastercard ||
            model.currentPaymentMethod == PaymentMethod.Visa)
          card(model, setState: setState)
        else
          momo(model, setState: setState),
        SizedBox(
          height: 30,
        ),
        ButtonComponent(
          text: "Make Payment",
          onTap: () {},
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}

card(CartViewModel model, {setState}) {
  return Column(
    children: [
      TextInputComponent(
        hintText: "Tiana Rosser",
        onChanged: (value) {
          setState(() {
            model.fullName.change(value);
          });
        },
        error: model.fullName.error,
      ),
      SizedBox(
        height: 15,
      ),
      TextInputComponent(
        hintText: "**** **** **** 3947",
        onChanged: (value) {
          setState(() {
            model.cardNumber.change(value);
          });
        },
        error: model.cardNumber.error,
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        children: [
          Expanded(
            child: TextInputComponent(
              hintText: "05",
              onChanged: (value) {
                setState(() {
                  model.cardDate.change(value);
                });
              },
              error: model.cardDate.error,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: TextInputComponent(
              hintText: "2023",
              onChanged: (value) {
                setState(() {
                  model.cardYear.change(value);
                });
              },
              error: model.cardYear.error,
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
              onChanged: (value) {
                setState(() {
                  model.cardPin.change(value);
                });
              },
              error: model.cardPin.error,
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

momo(CartViewModel model, {setState}) {
  return Column(
    children: [
      TextInputComponent(
        key: ValueKey("phone-number"),
        hintText: "Phone Number",
        onChanged: (value) {
          setState(() {
            model.phoneNumber.change(value);
          });
        },
        error: model.phoneNumber.error,
      ),
      if (model.currentPaymentMethod == PaymentMethod.VodafoneCash) ...[
        SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Expanded(
              child: TextInputComponent(
                hintText: "152658",
                onChanged: (value) {
                  setState(() {
                    model.voucher.change(value);
                  });
                },
                error: model.voucher.error,
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
      ]
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
