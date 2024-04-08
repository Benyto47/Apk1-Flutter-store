import 'package:apk1/providers/cart_provider.dart';
import 'package:apk1/providers/product_provider.dart';
import 'package:apk1/screen/cart/cart_widget.dart';
import 'package:apk1/widgets/empty_screen.dart';
import 'package:apk1/services/global_methode.dart';
import 'package:apk1/services/utils.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final Color color = Utils(context).color;
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList = cartProvider.getCartItems.values.toList().reversed.toList();

    return cartItemsList.isEmpty
        ? const EmptyScreen(
          title: 'Your cart is empty',
          subtitle: 'Add something and make me happy :',
          buttontext: 'shop now',
          imagePath: 'assets/images/cart.png',
        )
        :  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Textwidget(
          text: 'Cart (${cartItemsList.length})', 
          color: color, 
          textSizes: 22,
          isTitle: true,),
        actions: [
          IconButton(onPressed: (){
             GlobalMethods.WarnigDialog(
                    title: 'Empty your cart?',
                    subtitle: 'Are you sure? ',
                    fct: () async{
                       await cartProvider.clearOnlineCart();
                       cartProvider.clearLocalCart();
                    },
                    context: context);
          }, icon: Icon(
            IconlyBroken.delete,
            color: color,
          ))
        ],
      ),
      body: Column(
        children: [
          _chekout(context: context),
          Expanded(
            child: ListView.builder(
              itemCount: cartItemsList.length,
              itemBuilder: (ctx, index){
              return ChangeNotifierProvider.value(
                value: cartItemsList[index],
                child: CardWidget(
                  q: cartItemsList[index].quantity,
                ));
            }),
          ),
        ],
      ) ,
    );
  }

  Widget _chekout({required BuildContext context}){

    final Color color = Utils(context).color;
    Size size = Utils(context).getScreensize;
    final cartProvider = Provider.of<CartProvider>(context);
    final productsProvider = Provider.of<ProductsProvider>(context);
    double total = 0.0;

    cartProvider.getCartItems.forEach((key, value) {
      final getCurrtProduct = productsProvider.findProductById(value.productId);
      total += (getCurrtProduct.isOnsale
                ? getCurrtProduct.salePrice
                : getCurrtProduct.price) * value.quantity;
    },);

    return     SizedBox(
            width: double.infinity,
            height: size.height*0.1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(children: [
                Material(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(10),
                    onTap: (){
                      
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Textwidget(
                        text: 'Oder Now', 
                        color: Colors.white, 
                        textSizes: 20),
                    ),
                  ),
                ),
                const Spacer(),
                FittedBox(
                  child: Textwidget(
                    text: 'Total: \$${total.toStringAsFixed(2)}', 
                    color: color, 
                    textSizes: 18, 
                    isTitle: true,))
              ],),
            ),
          );
  }
}
