import 'dart:ui';

import 'package:apk1/inner_screen/product_details.dart';
import 'package:apk1/models/cart_model.dart';
import 'package:apk1/providers/cart_provider.dart';
import 'package:apk1/providers/product_provider.dart';
import 'package:apk1/providers/wishlist_provider.dart';
import 'package:apk1/services/utils.dart';
import 'package:apk1/widgets/heart_btn.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required this.q});

  final int q;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final _quantityTextController = TextEditingController();
  @override
  void initState() {
    _quantityTextController.text = widget.q.toString();
    super.initState();
  }
  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreensize;
    final productsProviders = Provider.of<ProductsProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final getCurrProduct = productsProviders.findProductById(cartModel.productId);
    double usedPrice = getCurrProduct.isOnsale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    final cartProvider = Provider.of<CartProvider>(context);

    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getWislistItems.containsKey(getCurrProduct.id);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: cartModel.productId);
      },
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      height: size.height * 0.17,
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: FancyShimmerImage(
                        imageUrl: getCurrProduct.imageUrl,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Textwidget(text: getCurrProduct.title, color: color, textSizes: 20, isTitle: true,),
                        const SizedBox(height: 16.0,),
                        SizedBox(
                          width: size.width*0.3,
                          child: Row(
                            children: [
                              _quantityController(
                                fct: (){
                                  if(_quantityTextController.text == '1'){
                                    return;
                                  }else{
                                     cartProvider.reduceQuantityByOne(
                                          cartModel.productId);
                                    setState(() {
                                        _quantityTextController.text =
                                            (int.parse(_quantityTextController
                                                        .text) -
                                                    1)
                                                .toString();
                                      });
                                  }
                                }, 
                                icon: CupertinoIcons.minus, 
                                color: Colors.red),
              
                              Flexible(
                                flex: 1,
                                child: TextField(
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide()
                                    )
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]')
                                    )
                                  ],
                                  onChanged: (v){
                                    setState(() {
                                      if(v.isEmpty){
                                        _quantityTextController.text = '1';
                                      }else{
                                        return;
                                      }
                                    });
                                  },
                                ),
                              ),
              
                                _quantityController(
                                fct: (){
                                    cartProvider.increaseQuantityByOne(
                                        cartModel.productId);
                                  setState(() {
                                    _quantityTextController.text = (int.parse(_quantityTextController.text)+1).toString();
                                  });
                                }, 
                                icon: CupertinoIcons.plus, 
                                color: Colors.green),
                            ],
                          ),
                        ),
                      ],
                    ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Column(children: [
                          InkWell(
                            onTap: ()async{
                              await cartProvider.removeOneItem(
                                cartId: cartModel.id,
                                productId: cartModel.productId,
                                quantity: cartModel.quantity
                              );
                            },
                            child: const Icon(
                              CupertinoIcons.cart_badge_minus,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                          const SizedBox(height: 5,),
                          HeartBTN(
                        productId: getCurrProduct.id,
                        isInWishlist: _isInWishlist,
                      ),
                          Textwidget(
                            text: '\$${(usedPrice * int.parse(_quantityTextController.text)).toStringAsFixed(2)}', 
                            color: color, 
                            textSizes: 18,
                            maxLines: 1,)
                        ],),),
                        const SizedBox(width: 5,)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _quantityController({required Function fct , required IconData icon, required Color color}){
    return  Flexible(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: Material(
                                  color: color,
                                  borderRadius: BorderRadius.circular(12),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(12),
                                    onTap: (){
                                      fct();
                                    },
                                    child:  Padding(
                                      padding:const EdgeInsets.all(6.0),
                                      child: Icon(
                                        icon, 
                                        color: Colors.white,),
                                    ),
                                  ),
                                ),
                              ),
                            );
  }
}