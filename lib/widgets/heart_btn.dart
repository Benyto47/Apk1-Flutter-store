import 'package:apk1/consts/firebase_const.dart';
import 'package:apk1/providers/product_provider.dart';
import 'package:apk1/providers/wishlist_provider.dart';
import 'package:apk1/services/global_methode.dart';
import 'package:apk1/services/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class HeartBTN extends StatelessWidget {
  const HeartBTN({super.key, required this.productId,  this.isInWishlist = false});

  final String productId;
  final bool? isInWishlist;

  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductsProvider>(context);
     final getCurrProduct = productProviders.findProductById(productId);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
                              onTap: () async{
                                try {
                                  final User? user = authInstance.currentUser;
                                  if (user == null) {
                                    GlobalMethods.errorgDialog(
                                        subtitle: 'No user dound, please login first',
                                        context: context);
                                    return;
                                  }
                                  if(isInWishlist == false && isInWishlist != null){
                                    await GlobalMethods.addToWishlist(productId: productId, context: context);
                                  }else{
                                    await wishlistProvider.removeOneItem(
                                      wishlistId: wishlistProvider.getWislistItems[getCurrProduct.id]!.id, 
                                      productId: productId);
                                  }
                                  await wishlistProvider.fetchWishlist();
                                } catch (error) {
                                  
                                }finally{}
                                //print('user id is ${user!.uid}');
                                // wishlistProvider.addRemouveProductsToWishlist(productId: productId);
                              },
                              child: Icon(
                                isInWishlist != null && isInWishlist == true
                                ? IconlyBold.heart
                                : IconlyLight.heart,
                                size: 22,
                                color: isInWishlist != null && isInWishlist == true ? Colors.red : color,
                              ),
                            );
  }
}