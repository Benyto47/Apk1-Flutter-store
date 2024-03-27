import 'package:apk1/inner_screen/product_details.dart';
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
  @override
  Widget build(BuildContext context) {

    final Color color = Utils(context).color;
    Size size = Utils(context).getScreensize;
    
    return ListTile(
      subtitle: const Text('Paid: \$12.8'),
      onTap: () {
        GlobalMethods.navigateTo(
            ctx: context, routeName: ProductDetails.routeName);
      },
      leading: FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: 'https://i.ibb.co/F0s3FHQ/Apricots.png',
        boxFit: BoxFit.fill,
      ),
      title: Textwidget(text: 'Title  x12', color: color, textSizes: 18),
      trailing: Textwidget(text: '03/08/2022', color: color, textSizes: 18),
    );
  }
}
