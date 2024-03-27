import 'package:apk1/inner_screen/product_details.dart';
import 'package:apk1/providers/cart_provider.dart';
import 'package:apk1/providers/wishlist_provider.dart';
import 'package:apk1/services/utils.dart';
import 'package:apk1/widgets/heart_btn.dart';
import 'package:apk1/widgets/price_widget.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:apk1/models/products_model.dart';
import 'package:provider/provider.dart';


class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({super.key});

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  

  @override
  Widget build(BuildContext context) {
    
    final productModel = Provider.of<ProductModel>(context);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreensize;
    final cartProvider = Provider.of<CartProvider>(context);
    bool? _isInCart = cartProvider.getCartItems.containsKey(productModel.id);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    bool? _isInWishlist =
        wishlistProvider.getWislistItems.containsKey(productModel.id);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: (){
            Navigator.pushNamed(context, ProductDetails.routeName,
                arguments: productModel.id);
            //GlobalMethods.navigateTo(ctx: context, routeName: ProductDetails.routeName);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FancyShimmerImage(imageUrl: 
                  productModel.imageUrl,
                  height: size.height * 0.11,
                  width: size.width * 0.22,
                  boxFit: BoxFit.fill,
                  ),
                  Column(children: [
                    Textwidget(
                      text: productModel.isPiece? 'piece' : '1KG', 
                      color: color, 
                      textSizes: 22, 
                      isTitle: true,),
                    const SizedBox(height: 6,),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                             cartProvider.addProductsToCart(
                                    productId: productModel.id,
                                    quantity: 1);
                          },
                          child: Icon(
                            _isInCart
                            ? IconlyBold.bag2
                            : IconlyLight.bag2,
                            size: 22,
                            color:_isInCart? Colors.green : color,
                          ),
                        ),
                        HeartBTN(
                        productId: productModel.id,
                        isInWishlist: _isInWishlist,
                      ),
                      ],
                    ),
                  ],)
                ],
              ),
               PriceWidget(
                salePrice: productModel.salePrice,
                  price: productModel.price,
                  textPrice: '1',
                  isOnsale: true,
              ),
              const SizedBox(height: 5,),
              Textwidget(
                text: productModel.title, 
                color: color, 
                textSizes: 16, 
                isTitle: true,),
              const SizedBox(
                  height: 5,
                )
            ],),
          ) ,
        ),
      ),
    );
  }
}