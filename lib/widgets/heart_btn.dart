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

class HeartBTN extends StatefulWidget {
  const HeartBTN({super.key, required this.productId,  this.isInWishlist = false});

  final String productId;
  final bool? isInWishlist;

  @override
  State<HeartBTN> createState() => _HeartBTNState();
}

class _HeartBTNState extends State<HeartBTN> {
  
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final productProviders = Provider.of<ProductsProvider>(context);
     final getCurrProduct = productProviders.findProductById(widget.productId);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
                              onTap: () async{
                                setState(() {
                                  loading = true;
                                });
                                try {
                                  final User? user = authInstance.currentUser;
                                  if (user == null) {
                                    GlobalMethods.errorgDialog(
                                        subtitle: 'No user dound, please login first',
                                        context: context);
                                    return;
                                  }
                                  if(widget.isInWishlist == false && widget.isInWishlist != null){
                                    await GlobalMethods.addToWishlist(productId: widget.productId, context: context);
                                  }else{
                                    await wishlistProvider.removeOneItem(
                                      wishlistId: wishlistProvider.getWislistItems[getCurrProduct.id]!.id, 
                                      productId: widget.productId);
                                  }
                                  await wishlistProvider.fetchWishlist();
                                  setState(() {
                                    loading = true;
                                  });
                                } catch (error) {
                                  GlobalMethods.errorgDialog(subtitle: '$error', context: context);
                                }finally{
                                  setState(() {
                                    loading = false;
                                  });
                                }
                                //print('user id is ${user!.uid}');
                                // wishlistProvider.addRemouveProductsToWishlist(productId: productId);
                              },
                              child: loading 
                              ?const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: SizedBox(height: 15, width: 15, child: CircularProgressIndicator()),
                              ) 
                              :Icon(
                                widget.isInWishlist != null && widget.isInWishlist == true
                                ? IconlyBold.heart
                                : IconlyLight.heart,
                                size: 22,
                                color: widget.isInWishlist != null && widget.isInWishlist == true ? Colors.red : color,
                              ),
                            );
  }
}