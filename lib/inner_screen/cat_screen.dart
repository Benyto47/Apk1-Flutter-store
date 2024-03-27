import 'package:apk1/consts/consts.dart';
import 'package:apk1/models/products_model.dart';
import 'package:apk1/providers/product_provider.dart';
import 'package:apk1/services/utils.dart';
import 'package:apk1/widgets/back_widget.dart';
import 'package:apk1/widgets/empty_product_widget.dart';
import 'package:apk1/widgets/feed_items.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

class CaregoryScreen extends StatefulWidget {
  static const routeName = "/CaregoryScreenState";
  const CaregoryScreen({super.key});

  @override
  State<CaregoryScreen> createState() => _CaregoryScreenState();
}

class _CaregoryScreenState extends State<CaregoryScreen> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreensize;
    final Color color = Utils(context).color;
    final productProviders = Provider.of<ProductsProvider>(context);

    final catName = ModalRoute.of(context)!.settings.arguments as String;
    List<ProductModel> productByCat = productProviders.findByCategory(catName);

    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        centerTitle: true,
        title: Textwidget(
          text: 'All Products',
          color: color,
          textSizes: 24.0,
          isTitle: true,
        ),
      ),
      body: productByCat.isEmpty
      ? const EmptyProdWidget(
        text: 'No prodducts belong to this category',
      )
      : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: kBottomNavigationBarHeight,
                child: TextField(
                  controller: _searchTextController,
                  onChanged: (value) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.greenAccent, width: 1)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Colors.greenAccent, width: 1)),
                      hintText: "What's in your nind",
                      prefixIcon: const Icon(Icons.search),
                      suffix: IconButton(
                        onPressed: () {
                          _searchTextController!.clear();
                          _searchTextFocusNode.unfocus();
                        },
                        icon: Icon(
                          Icons.close,
                          color: _searchTextFocusNode.hasFocus
                              ? color
                              : Colors.red,
                        ),
                      )),
                ),
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              //crossAxisSpacing: 18,
              childAspectRatio: size.width / (size.height * 0.6),
              children: List.generate(productByCat.length, (index) {
                return ChangeNotifierProvider.value(
                    value: productByCat[index], child: const FeedsWidget());
              }),
            )
          ],
        ),
      ),
    );
  }
}
