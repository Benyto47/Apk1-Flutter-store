import 'package:apk1/provider/dark_theme_provider.dart';
import 'package:apk1/providers/cart_provider.dart';
import 'package:apk1/screen/cart/cart_screen.dart';
import 'package:apk1/screen/categories.dart'; // Corrected typo
import 'package:apk1/screen/home_screen.dart';
import 'package:apk1/screen/user.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class BottomBarScreen extends StatefulWidget {
  const BottomBarScreen({super.key});

  @override
  State<BottomBarScreen> createState() => _BottomBarScreemState();
}

class _BottomBarScreemState extends State<BottomBarScreen> {
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> _pages = [
    {'page': const HomeScreen(), 'Title': 'Home Screen'},
    {'page':  CategorisesScreen(), 'Title': 'Categories Screen'},
    {'page': const CartScreen(), 'Title': 'Cart Screen'},
    {'page': const UserScreen(), 'Title': 'User Screen'},
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      // Uncomment and set title based on _selectedIndex if needed
      // appBar: AppBar(
      //   title: Text(_pages[_selectedIndex]['Title']),
      // ),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeState.getDarkTheme
            ? Theme.of(context).cardColor
            : Colors.white,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: _selectPage,
        unselectedItemColor:
            themeState.getDarkTheme ? Colors.white10 : Colors.black,
        selectedItemColor: themeState.getDarkTheme
            ? Colors.lightBlue.shade200
            : Colors.black87,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Icon(_selectedIndex == 0 ? IconlyBold.home : IconlyLight.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(_selectedIndex == 1
                ? IconlyBold.category
                : IconlyLight.category),
            label: "Categories",
          ),
          BottomNavigationBarItem(
            icon: Consumer<CartProvider>(
              builder: (_, myCart, ch) {
                return badges.Badge(
                  badgeContent: Textwidget(text: myCart.getCartItems.length.toString(), color: Colors.white, textSizes: 15),
                  badgeStyle: const badges.BadgeStyle(
                    badgeColor: Colors.blue
                  ),
                  child: Icon(_selectedIndex == 2
                      ? IconlyBold.buy
                      : IconlyLight.buy), // Ternary operator for dynamic icon
                );
              }
            ),
            label: "Cart",
          ),

          BottomNavigationBarItem(
            icon: Icon(
                _selectedIndex == 3 ? IconlyBold.user2 : IconlyLight.user2),
            label: "User",
          ),
        ],
      ),
    );
  }
}
