import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({Key? key, required this.salePrice, required this.price, required this.textPrice, required this.isOnsale}) : super(key: key);

  final double salePrice, price;
  final String textPrice;
  final bool isOnsale;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    double userPrice = isOnsale? salePrice : price;

    return FittedBox(
        child: Row(
      children: [
        Textwidget(
          text: '\$${(userPrice * int.parse(textPrice)).toStringAsFixed(2)}', 
          color: Colors.green, textSizes: 18),
        const SizedBox(
          width: 5,
        ),
        Visibility(
          visible: isOnsale? true : false,
          child: Text(
            '\$${(price * int.parse(textPrice)).toStringAsFixed(2)}',
             style: TextStyle(
              fontSize: 15,
              color: color,
              decoration: TextDecoration.lineThrough,
            ),
          ),
        )
      ],
    ));
  }
}
