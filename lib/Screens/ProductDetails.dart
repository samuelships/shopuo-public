import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:shopuo/Components/Button/ButtonComponent.dart';
import 'package:shopuo/Components/HeaderComponent.dart';
import 'package:shopuo/Models/ProductModel.dart';
import 'package:shopuo/Styles/Color.dart';
import 'package:shopuo/Styles/Typography.dart';
import 'package:shopuo/ViewModels/ProductDetailsViewModel.dart';

import '../locator.dart';

class ProductDetails extends StatefulWidget {
  static Widget create({product}) {
    return ChangeNotifierProvider<ProductDetailsViewModel>(
      create: (_) => locator<ProductDetailsViewModel>(),
      child: ProductDetails(
        product: product,
      ),
    );
  }

  final ProductModel product;

  const ProductDetails({Key key, this.product}) : super(key: key);
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  ProductModel _product = products[0];

  int _currentSize = 2;
  int _currentColor = 3;
  int _currentQuantity = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: HeaderComponent(
          leading: "assets/svg_icons/chevron-left.svg",
          leadingCallback: Navigator.of(context).pop,
          title: "Product Details",
        ),
        body: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Container(
                height: MediaQuery.of(context).size.width,
                child: Stack(
                  overflow: Overflow.clip,
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      fadeOutDuration: Duration(milliseconds: 0),
                      fadeInDuration: Duration(milliseconds: 0),
                      fadeInCurve: Curves.linear,
                      fit: BoxFit.cover,
                      imageUrl: widget.product.image,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        color: Colors.grey,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.black,
                                Colors.black.withOpacity(.0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 25,
                      bottom: 25,
                      child: Text(
                        "\$${widget.product.price}",
                        style: MyTypography.bigHeader.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 70,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: widget.product.secondaryImages.length,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(right: 10),
                  height: 70,
                  width: 70,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    child: CachedNetworkImage(
                      fadeOutDuration: Duration(milliseconds: 0),
                      fadeInDuration: Duration(milliseconds: 0),
                      fadeInCurve: Curves.linear,
                      fit: BoxFit.cover,
                      imageUrl: widget.product.secondaryImages[index],
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.product.category}",
                    style: MyTypography.heading5SB.copyWith(
                      color: MyColor.primaryPurple,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 255,
                    child: Text(
                      "${widget.product.name}",
                      style: MyTypography.heading1SB.copyWith(
                        color: MyColor.neutralBlack,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    "${widget.product.description}",
                    style: MyTypography.heading6R.copyWith(
                      color: MyColor.neutralBlack,
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Divider(
                    color: MyColor.dividerLight,
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Sizes",
                    style: MyTypography.heading5SB.copyWith(
                      color: MyColor.neutralBlack,
                    ),
                  ),
                  SizedBox(
                    height: 22,
                  ),
                  Wrap(
                    children: [
                      ...widget.product.sizes
                          .asMap()
                          .map(
                            (index, value) => MapEntry(
                              index,
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _currentSize = index;
                                  });
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 20, bottom: 20),
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(
                                    color: _currentSize == index
                                        ? MyColor.primaryPurple
                                        : Colors.white,
                                    border:
                                        Border.all(color: MyColor.dividerLight),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Center(
                                    child: Text(
                                      value,
                                      style: _currentSize == index
                                          ? MyTypography.heading6SB
                                          : MyTypography.heading6SB.copyWith(
                                              color: MyColor.neutralGrey4),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .values
                          .toList()
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Text(
                    "Colors",
                    style: MyTypography.heading5SB.copyWith(
                      color: MyColor.neutralBlack,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    children: [
                      ...widget.product.colors
                          .asMap()
                          .map(
                            (index, value) => MapEntry(
                              index,
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _currentColor = index;
                                  });
                                },
                                child: Container(
                                  margin:
                                      EdgeInsets.only(right: 20, bottom: 20),
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: value.value,
                                    boxShadow: [
                                      BoxShadow(
                                        blurRadius: 16,
                                        offset: Offset(0, 16),
                                        color:
                                            Color(0xff323247).withOpacity(.08),
                                      ),
                                    ],
                                    border: Border.all(
                                      color: _currentColor == index
                                          ? MyColor.primaryPurple
                                          : Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                          .values
                          .toList()
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _currentQuantity++;
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 2,
                                color: Color(0xff323247).withOpacity(.06),
                              ),
                              BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                color: Color(0xff323247).withOpacity(.06),
                              ),
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/svg_icons/plus.svg",
                              color: MyColor.neutralGrey3,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 32,
                        width: 32,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 2,
                              color: Color(0xff323247).withOpacity(.06),
                            ),
                            BoxShadow(
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              color: Color(0xff323247).withOpacity(.06),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "$_currentQuantity",
                            style: MyTypography.heading6SB.copyWith(
                              color: MyColor.primaryPurple,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_currentQuantity > 0) {
                              _currentQuantity--;
                            }
                          });
                        },
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 2,
                                color: Color(0xff323247).withOpacity(.06),
                              ),
                              BoxShadow(
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                color: Color(0xff323247).withOpacity(.06),
                              ),
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              "assets/svg_icons/minus.svg",
                              color: MyColor.neutralGrey3,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  ButtonComponent(
                    text: "Add to cart",
                    onTap: () {},
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
