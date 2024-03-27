import 'package:apk1/inner_screen/product_details.dart';
import 'package:apk1/models/wishlist_model.dart';
import 'package:apk1/providers/product_provider.dart';
import 'package:apk1/providers/wishlist_provider.dart';
import 'package:apk1/services/utils.dart';
import 'package:apk1/widgets/heart_btn.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class WishlistWidget extends StatelessWidget {
  const WishlistWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final productsProviders = Provider.of<ProductsProvider>(context);
    final wishlistModel = Provider.of<WishlistModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final getCurrProduct = productsProviders.findProductById(wishlistModel.productId);
    double usedPrice = getCurrProduct.isOnsale
        ? getCurrProduct.salePrice
        : getCurrProduct.price;
    
    bool? _isInWishlist =
        wishlistProvider.getWislistItems.containsKey(getCurrProduct.id);

    Size size = Utils(context).getScreensize;
    final Color color = Utils(context).color;
   

    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: wishlistModel.productId);
        },
        child: Container(
          height: size.height*0.20,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            border: Border.all(color: color, width: 1),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Flexible(
                flex: 2,
                child: Container(
                  margin: const EdgeInsets.only(left: 8),
                  //width: size.width*0.2,
                  height: size.height*0.25,
                  child: FancyShimmerImage(
                    imageUrl: getCurrProduct.imageUrl,
                    boxFit: BoxFit.fill,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: (){}, 
                             icon: Icon(
                              IconlyLight.bag2,
                              color: color,
                             )),
                            HeartBTN(
                          productId: getCurrProduct.id,
                          isInWishlist: _isInWishlist,
                        ),
                        ],
                      ),
                    ),
                      Textwidget(
                      text: getCurrProduct.title, 
                      color: color, 
                      textSizes: 20.0,
                      maxLines: 1,
                      isTitle: true,),
                      const SizedBox(height: 5,),
                      Textwidget(
                        text: '\$${usedPrice.toStringAsFixed(2)}',
                        color: color,
                        textSizes: 20.0,
                        maxLines: 2,
                        isTitle: true,
                      )
                  ],
                ),
              )
            ],
          ),
        )),
    );
  }
}