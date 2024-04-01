import 'package:apk1/consts/firebase_const.dart';
import 'package:apk1/providers/cart_provider.dart';
import 'package:apk1/providers/product_provider.dart';
import 'package:apk1/providers/wishlist_provider.dart';
import 'package:apk1/services/global_methode.dart';
import 'package:apk1/widgets/back_widget.dart';
import 'package:apk1/widgets/heart_btn.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:provider/provider.dart';

import '../services/utils.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final _quantityTextController = TextEditingController(text: '1');

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreensize;
    final Color color = Utils(context).color;
    final productProviders = Provider.of<ProductsProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productProviders.findProductById(productId);
    double usedPrice = getCurrProduct.isOnsale? getCurrProduct.salePrice : getCurrProduct.price ;
    double totalPrice = usedPrice * int.parse(_quantityTextController.text);

     bool? _isInCart = cartProvider.getCartItems.containsKey(getCurrProduct.id);

     final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getWislistItems.containsKey(getCurrProduct.id);

    return Scaffold(
      appBar: AppBar(
          leading:const BackWidget(),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor),
      body: Column(children: [
        Flexible(
          flex: 2,
          child: FancyShimmerImage(
            imageUrl: getCurrProduct.imageUrl,
            boxFit: BoxFit.scaleDown,
            width: size.width,
            // height: screenHeight * .4,
          ),
        ),
        Flexible(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Textwidget(
                          text: getCurrProduct.title,
                          color: color,
                          textSizes: 25,
                          isTitle: true,
                        ),
                      ),
                      HeartBTN(
                        productId: getCurrProduct.id,
                        isInWishlist: _isInWishlist,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Textwidget(
                        text: '\$${usedPrice.toStringAsFixed(2)}/',
                        color: Colors.green,
                        textSizes: 22,
                        isTitle: true,
                      ),
                      Textwidget(
                        text: getCurrProduct.isPiece? 'piece' : '/Kg',
                        color: color,
                        isTitle: false, textSizes: 12,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Visibility(
                        visible: getCurrProduct.isOnsale? true : false,
                        child: Text(
                          '\$${getCurrProduct.price.toStringAsFixed(2)}',
                          style: TextStyle(
                              fontSize: 15,
                              color: color,
                              decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 8),
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(63, 200, 101, 1),
                            borderRadius: BorderRadius.circular(5)),
                        child: Textwidget(
                          text: 'Free delivery',
                          color: Colors.white,
                          textSizes: 20,
                          isTitle: true,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    quantityControl(
                      fct: () {
                        if (_quantityTextController.text == '1') {
                          return;
                        } else {
                          setState(() {
                            _quantityTextController.text =
                                (int.parse(_quantityTextController.text) - 1)
                                    .toString();
                          });
                        }
                      },
                      icon: CupertinoIcons.minus_square,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        controller: _quantityTextController,
                        key: const ValueKey('quantity'),
                        keyboardType: TextInputType.number,
                        maxLines: 1,
                        decoration: const InputDecoration(
                          border: UnderlineInputBorder(),
                        ),
                        textAlign: TextAlign.center,
                        cursorColor: Colors.green,
                        enabled: true,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        ],
                        onChanged: (value) {
                          setState(() {
                            if (value.isEmpty) {
                              _quantityTextController.text = '1';
                            } else {}
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    quantityControl(
                      fct: () {
                        setState(() {
                          _quantityTextController.text =
                              (int.parse(_quantityTextController.text) + 1)
                                  .toString();
                        });
                      },
                      icon: CupertinoIcons.plus_square,
                      color: Colors.green,
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Textwidget(
                              text: 'Total',
                              color: Colors.red.shade300,
                              textSizes: 20,
                              isTitle: true,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            FittedBox(
                              child: Row(
                                children: [
                                  Textwidget(
                                    text: '\$${totalPrice.toStringAsFixed(2)}/',
                                    color: color,
                                    textSizes: 20,
                                    isTitle: true,
                                  ),
                                  Textwidget(
                                    text: '${_quantityTextController.text}Kg',
                                    color: color,
                                    textSizes: 16,
                                    isTitle: false,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        child: Material(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            onTap:  _isInCart
                                ? null
                                : () {
                                   final User? user = authInstance.currentUser;
                                    if (user == null) {
                                      GlobalMethods.errorgDialog(
                                          subtitle:
                                              'No user dound, please login first',
                                          context: context);
                                      return;
                                    }
                                    cartProvider.addProductsToCart(
                                        productId: getCurrProduct.id,
                                        quantity: int.parse(
                                            _quantityTextController.text));
                                  },
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Textwidget(
                                    text: _isInCart? 'In cart' : 'Add to cart',
                                    color: Colors.white,
                                    textSizes: 18)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget quantityControl(
      {required Function fct, required IconData icon, required Color color}) {
    return Flexible(
      flex: 2,
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: color,
        child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 25,
              ),
            )),
      ),
    );
  }
}
