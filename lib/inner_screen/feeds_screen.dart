import 'package:apk1/models/products_model.dart';
import 'package:apk1/providers/product_provider.dart';
import 'package:apk1/services/utils.dart';
import 'package:apk1/widgets/back_widget.dart';
import 'package:apk1/widgets/empty_product_widget.dart';
import 'package:apk1/widgets/feed_items.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeesdScreen extends StatefulWidget {
  static const routeName = "/FeedsScreenState";
  const FeesdScreen({super.key});

  @override
  State<FeesdScreen> createState() => _FeesdScreenState();
}

class _FeesdScreenState extends State<FeesdScreen> {

  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();

  @override
  void dispose() {
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    final productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    productsProvider.fetchProducts();
    super.initState();
  }

  List<ProductModel> listProductSearch = [];
  
  @override
  Widget build(BuildContext context) {

    Size size = Utils(context).getScreensize;
    final Color color = Utils(context).color;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;

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
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: kBottomNavigationBarHeight,
              child: TextField(
                controller: _searchTextController,
                onChanged: (value){
                 setState(() {
                      listProductSearch = productProviders.searchQuery(value);
                    });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.greenAccent, width: 1)),
                    enabledBorder:  OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide:
                            const BorderSide(color: Colors.greenAccent, width: 1)),
                            hintText: "What's in your nind",
                            prefixIcon: const Icon(Icons.search),
                            suffix: IconButton(
                              onPressed: (){
                                _searchTextController!.clear();
                                _searchTextFocusNode.unfocus();
                              }, 
                              icon: Icon(
                                Icons.close, 
                                color: _searchTextFocusNode.hasFocus ? color : Colors.red,),)
                ),
              ),
            ),
          ),
          _searchTextController!.text.isNotEmpty && listProductSearch.isEmpty
                ? const EmptyProdWidget(
                    text: 'No product found, please try another keyword')
                : GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    padding: EdgeInsets.zero,
                    //crossAxisSpacing: 18,
                    childAspectRatio: size.width / (size.height * 0.6),
                    children: List.generate(
                        _searchTextController!.text.isNotEmpty
                            ? listProductSearch.length
                            : allProducts.length, (index) {
                      return ChangeNotifierProvider.value(
                          value: _searchTextController!.text.isNotEmpty
                              ? listProductSearch[index]
                              : allProducts[index],
                          child: const FeedsWidget());
                    }),
                  )
        ],),
      ),
    );
  }
}