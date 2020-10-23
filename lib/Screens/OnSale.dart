import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shopuo/Components/BottomNavComponent.dart';
import 'package:shopuo/Components/InternetErrorComponent.dart';
import 'package:shopuo/Components/LoadingComponent.dart';
import 'package:shopuo/Components/ProductCard.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import "../Models/ProductModel.dart";

class OnSale extends StatefulWidget {
  @override
  _OnSaleState createState() => _OnSaleState();
}

class _OnSaleState extends State<OnSale> {
  final List<ProductModel> _products = products;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                    "assets/svg_icons/package.svg",
                    height: 28,
                    width: 28,
                    color: MyColor.neutralBlack,
                  ),
                ),
                Text(
                  "On Sale",
                  style: MyTypography.heading5SB.copyWith(
                    color: MyColor.neutralBlack,
                  ),
                ),
                Transform.translate(
                  offset: Offset(10, 0),
                  child: SvgPicture.asset(
                    "assets/svg_icons/search.svg",
                    height: 28,
                    width: 28,
                    color: MyColor.neutralBlack,
                  ),
                )
              ],
            ),
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            // loading indicator
            if (false)
              Positioned.fill(child: LoadingComponent())
            else if (false)
              Positioned.fill(child: InternetErrorComponent())
            else
              GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: .7,
                ),
                itemCount: _products.length,
                itemBuilder: (contex, index) => ProductCard(
                  product: _products[index],
                ),
              )
          ],
        ),
        bottomNavigationBar: BottomNavComponent(
          currentIndex: 0,
        ),
      ),
    );
  }
}
