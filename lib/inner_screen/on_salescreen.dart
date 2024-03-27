import 'package:apk1/models/products_model.dart';
import 'package:apk1/providers/product_provider.dart';
import 'package:apk1/services/utils.dart';
import 'package:apk1/widgets/back_widget.dart';
import 'package:apk1/widgets/empty_product_widget.dart';
import 'package:apk1/widgets/on_sale_widget.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({super.key});

  @override
  Widget build(BuildContext context) {

    bool _isEmpty = false;

    Size size = Utils(context).getScreensize;
    final Color color = Utils(context).color;

    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productOnSale = productProviders.getOnSaleProducts;

    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Textwidget(text: 'Product on Sale', color: color, textSizes: 24.0, isTitle: true,),
      ),
      body: productOnSale.isEmpty == true 
      ? const EmptyProdWidget(
        text: 'No products on sale yet!, \nStay tuned',
      )  
      : GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        padding: EdgeInsets.zero,
        //crossAxisSpacing: 18,
        childAspectRatio: size.width / (size.height * 0.49),
        children: List.generate(productOnSale.length, (index) {
          return ChangeNotifierProvider.value(
                  value: productOnSale[index],
                  child: const OnSaleWidget());
        }),
      ),
    );
  }
}