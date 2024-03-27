import 'dart:typed_data';

import 'package:apk1/inner_screen/product_details.dart';
import 'package:apk1/providers/wishlist_provider.dart';
import 'package:apk1/screen/cart/cart_widget.dart';
import 'package:apk1/screen/wishlist/wishlist_whidget.dart';
import 'package:apk1/services/global_methode.dart';
import 'package:apk1/services/utils.dart';
import 'package:apk1/widgets/back_widget.dart';
import 'package:apk1/widgets/empty_screen.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class WishlistScreen extends StatelessWidget {
  static const routeName = "/WishlistScreen";
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreensize;
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final wishlistItemsList =
        wishlistProvider.getWislistItems.values.toList().reversed.toList();

    return wishlistItemsList.isEmpty
        ? const EmptyScreen(
            title: 'Your wishlist is empty',
            subtitle: 'Export more and shortlist some items',
            buttontext: 'Add a wish',
            imagePath: 'assets/images/wishlist.png',
          )
        :  Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Textwidget(
          text: 'Wishlist (${wishlistItemsList.length})', 
          color: color, 
          textSizes: 22,
          isTitle: true,),
        actions: [
          IconButton(onPressed: (){
             GlobalMethods.WarnigDialog(
                      title: 'Empty your wishlist?',
                      subtitle: 'Are you sure? ',
                      fct: () {
                        wishlistProvider.clearWishlist();
                      },
                      context: context);
          }, icon: Icon(
            IconlyBroken.delete,
            color: color,
          ))
        ],
      ),
      body: MasonryGridView.count(
        itemCount: wishlistItemsList.length,
          crossAxisCount: 2,
          //mainAxisSpacing: 4,
          //crossAxisSpacing: 4,
          itemBuilder: (context, index) {
            return ChangeNotifierProvider.value(
              value: wishlistItemsList[index],
              child: const WishlistWidget());
  },));
  }
  }