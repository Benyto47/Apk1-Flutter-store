import 'package:apk1/providers/wishlist_provider.dart';
import 'package:apk1/services/utils.dart';
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
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final Color color = Utils(context).color;
    return GestureDetector(
                              onTap: () {
                                wishlistProvider.addRemouveProductsToWishlist(productId: productId);
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