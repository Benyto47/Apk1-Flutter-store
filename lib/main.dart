import 'package:apk1/consts/theme_data.dart';
import 'package:apk1/fetch_screen.dart';
import 'package:apk1/inner_screen/cat_screen.dart';
import 'package:apk1/inner_screen/feeds_screen.dart';
import 'package:apk1/inner_screen/on_salescreen.dart';
import 'package:apk1/inner_screen/product_details.dart';
import 'package:apk1/providers/dark_theme_provider.dart';
import 'package:apk1/providers/cart_provider.dart';
import 'package:apk1/providers/order_provider.dart';
import 'package:apk1/providers/product_provider.dart';
import 'package:apk1/providers/viewed_prod_provider.dart';
import 'package:apk1/providers/wishlist_provider.dart';
import 'package:apk1/screen/auth/forget_pass.dart';
import 'package:apk1/screen/auth/loging.dart';
import 'package:apk1/screen/auth/register.dart';
import 'package:apk1/screen/btm_bar.dart';
import 'package:apk1/screen/orders/order_widget.dart';
import 'package:apk1/screen/viewed_recenty/viewed_recenty.dart';
import 'package:apk1/screen/wishlist/whislist_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp( MyApp());
}


class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePerfs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        }),
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => WishlistProvider()),
        ChangeNotifierProvider(create: (_) => ViewedProdProvider()),
        ChangeNotifierProvider(create: (_) => OrdersProvider()),
      ],
      child:
          Consumer<DarkThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: Styles.themeData(themeProvider.getDarkTheme, context),
          home: const FetchScreen(),
          routes: {
            OnSaleScreen.routeName: (ctx) => const OnSaleScreen(),
            FeesdScreen.routeName: (ctx) => const FeesdScreen(),
            ProductDetails.routeName: (ctx) => const ProductDetails(),
            WishlistScreen.routeName: (ctx) => const WishlistScreen(),
            OrdersScreen.routeName: (ctx) => const OrdersScreen(),
            ViewedRecentlyScreen.routeName: (ctx) =>
                const ViewedRecentlyScreen(),
            RegisterScreen.routeName: (ctx) => const RegisterScreen(),
            LoginScreen.routeName: (ctx) => const LoginScreen(),
            ForgetPasswordScreen.routeName: (ctx) =>
                const ForgetPasswordScreen(),
            CaregoryScreen.routeName: (ctx) => const CaregoryScreen(),
          },
        );
      }),
    );
  }
}
