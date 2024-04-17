import 'package:apk1/inner_screen/product_details.dart';
import 'package:apk1/models/orders_model.dart';
import 'package:apk1/providers/product_provider.dart';
import 'package:apk1/services/global_methode.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {

  late String orderDateToShow;
  
  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrderModel>(context);
    var orderDate = ordersModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}/';
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrderModel>(context);

    final Color color = Utils(context).color;
    Size size = Utils(context).getScreensize;
    final productProviders = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProviders.findProductById(ordersModel.productId);
    
    return ListTile(
      subtitle:  Text('Paid: \$${double.parse(ordersModel.price).toStringAsFixed(2)}'),
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetails.routeName);
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: getCurrProduct.imageUrl,
        boxFit: BoxFit.fill,
      ),
      title: Textwidget(text: '${getCurrProduct.title} *${ordersModel.quantity}', color: color, textSizes: 18),
      trailing: Textwidget(text: orderDateToShow, color: color, textSizes: 18),
    );
  }
}
