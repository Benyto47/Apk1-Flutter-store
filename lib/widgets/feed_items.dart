import 'package:apk1/consts/firebase_const.dart';
import 'package:apk1/inner_screen/product_details.dart';
import 'package:apk1/models/products_model.dart';
import 'package:apk1/providers/cart_provider.dart';
import 'package:apk1/providers/wishlist_provider.dart';
import 'package:apk1/services/global_methode.dart';
import 'package:apk1/services/utils.dart';
import 'package:apk1/widgets/heart_btn.dart';
import 'package:apk1/widgets/price_widget.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({super.key,});


  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {

  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text='1';
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
    final productModel = Provider.of<ProductModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    bool? _isInWishlist = wishlistProvider.getWislistItems.containsKey(productModel.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: (){
            Navigator.pushNamed(context, ProductDetails.routeName,
            arguments: productModel.id);
            //GlobalMethods.navigateTo(ctx: context, routeName: ProductDetails.routeName);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(children: [
            FancyShimmerImage(
                imageUrl: productModel.imageUrl,
                height: size.height * 0.11,
                width: size.width * 0.22,
                boxFit: BoxFit.fill,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible (
                      flex: 3,
                      child: 
                      Textwidget(
                        text: productModel.title, 
                        color: color , 
                        maxLines: 1,
                        textSizes: 18, 
                        isTitle: true, )),
                     Flexible(
                      flex: 1,
                      child:  HeartBTN(
                        productId: productModel.id,
                        isInWishlist: _isInWishlist,
                      )),
                  ],
                ),
              ),
               Padding(
                padding:const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Flexible(
                      flex: 3,
                       child: PriceWidget(
                        salePrice: productModel.salePrice,
                        price: productModel.price,
                        textPrice: _quantityTextController.text,
                        isOnsale: productModel.isOnsale,
                                           ),
                     ),
                    Flexible(
                      child: Row(children: [
                        Flexible(
                          flex: 6,
                          child: FittedBox(
                            child: 
                            Textwidget(
                              text: productModel.isPiece? 'piece' : 'KG', 
                              color: color, 
                              textSizes: 20, 
                              isTitle: true,)),
                        ),
                          const SizedBox(width: 5,),
                          Flexible(
                            child: TextFormField(
                            controller: _quantityTextController,
                            key: const ValueKey('10'),
                            style: TextStyle(color: color, fontSize: 18),
                            keyboardType: TextInputType.number,
                            maxLines: 1,
                            enabled: true,
                            onChanged: (value) {
                              setState(() {
                                
                              });
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
                            ],
                          ))
                      ],),
                    )
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: _isInCart? null : ()async{
                    final User? user = authInstance.currentUser;
                          if (user == null) {
                            GlobalMethods.errorgDialog(
                                subtitle: 'No user dound, please login first',
                                context: context);
                            return;
                          }
                           await GlobalMethods.addToCart(
                              productId: productModel.id,
                              quantity: int.parse(_quantityTextController.text),
                              context: context);
                              await cartProvider.fetchCart();
                    // cartProvider.addProductsToCart(
                    //   productId: productModel.id, 
                    //   quantity: int.parse(_quantityTextController.text));
                  }, 
                  child: Textwidget(
                    text: _isInCart? 'In cart' : 'Add to cart', 
                    color: color, textSizes: 20,
                    maxLines: 1,),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12.0),
                            bottomRight: Radius.circular(12.0)
                          )
                        )
                      )
                    ),),
              )
          ],),
        ),
      ),
    );
  }
}