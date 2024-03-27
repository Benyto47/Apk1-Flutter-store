import 'package:apk1/consts/consts.dart';
import 'package:apk1/inner_screen/feeds_screen.dart';
import 'package:apk1/inner_screen/on_salescreen.dart';
import 'package:apk1/models/products_model.dart';
import 'package:apk1/provider/dark_theme_provider.dart';
import 'package:apk1/providers/product_provider.dart';
import 'package:apk1/services/global_methode.dart';
import 'package:apk1/services/utils.dart';
import 'package:apk1/widgets/feed_items.dart';
import 'package:apk1/widgets/on_sale_widget.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:card_swiper/card_swiper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  
  
  @override
  Widget build(BuildContext context) {
    final themeState = Utils(context).getTheme;
    Size size = Utils(context).getScreensize;
    final Color color = Utils(context).color;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getOnSaleProducts;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.33,
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.asset(
                    Consts.offerImages[index],
                    fit: BoxFit.fill,
                  );
                },
                autoplay: true,
                itemCount: Consts.offerImages.length,
                pagination:const SwiperPagination(
                  alignment: Alignment.bottomCenter,
                  builder: DotSwiperPaginationBuilder(
                    color: Colors.white, activeColor: Colors.red
                  )
                ),
                //control:const SwiperControl(),
              ),
            ),
           const SizedBox(height: 3,),
            TextButton(
              onPressed: (){
                GlobalMethods.navigateTo( 
                  ctx: context, routeName: OnSaleScreen.routeName);}, 
            child: Textwidget(
              text: 'View all', maxLines: 1 , color: Colors.blue, textSizes: 20)),
              const SizedBox(
              height: 3,
            ),
            Row(
              children: [
                RotatedBox(
                  quarterTurns: -1,
                  child: Row(
                    children: [
                      Textwidget(text: 'On sale'.toUpperCase(), color: Colors.red, textSizes: 22, isTitle: true,),
                      const SizedBox(width: 5,), 
                      const Icon(
                        IconlyLight.discount,
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 8,),
                Flexible(
                  child: SizedBox(
                    height: size.height*0.24,
                    child: ListView.builder(
                      itemCount: allProducts.length < 10 ?
                      allProducts.length 
                      : 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                      return ChangeNotifierProvider.value(
                            value: allProducts[index],
                            child: const OnSaleWidget());
                    },),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Textwidget(text: 'Our products', color: color, textSizes: 22, isTitle: true,),
                //const Spacer(),
                TextButton(
                      onPressed: () {
                        GlobalMethods.navigateTo( 
                          ctx: context, routeName: FeesdScreen.routeName);
                      },
                      child: Textwidget(
                          text: 'Browse all',
                          maxLines: 1,
                          color: Colors.blue,
                          textSizes: 20))
              ],),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              //crossAxisSpacing: 18,
              childAspectRatio: size.width / (size.height * 0.6),
              children: List.generate(
                allProducts.length < 4 
                ? allProducts.length 
                : 4, (index){
                return   ChangeNotifierProvider.value(
                  value: allProducts[index],
                  child: const FeedsWidget());
              }), )
          ],
        ),
      ),
    );
  }
}
