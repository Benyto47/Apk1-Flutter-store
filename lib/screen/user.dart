import 'dart:async';

import 'package:apk1/consts/firebase_const.dart';
import 'package:apk1/providers/dark_theme_provider.dart';
import 'package:apk1/screen/auth/forget_pass.dart';
import 'package:apk1/screen/auth/loging.dart';
import 'package:apk1/screen/loading_manager.dart';
import 'package:apk1/screen/orders/order_widget.dart';
import 'package:apk1/screen/viewed_recenty/viewed_recenty.dart';
import 'package:apk1/screen/wishlist/whislist_screen.dart';
import 'package:apk1/services/global_methode.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final TextEditingController _addressTextController = TextEditingController(text: "");
  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }
  
  String? _email;
  String? _name;
  String? address;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData()async{
    setState(() {
      _isLoading = true;
    });

    if(user == null){
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;

      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(_uid).get();

      if(userDoc == null){
        return;
      }else{
        _email = userDoc.get('email');
        _name = userDoc.get('name');
        address = userDoc.get('shipping-adress');
        _addressTextController.text = userDoc.get('shipping-adress');
      }

    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorgDialog(
          subtitle: '$error', context: context);
    }finally{
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black; // Get dynamic color

    return Scaffold(
      body: LoadingManger(
        isLoading: _isLoading,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   const SizedBox(
                    height: 5,
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Hi, ',
                      style: const TextStyle(
                        color: Colors.cyan, 
                        fontSize: 27, fontWeight: 
                        FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                          text: _name == null ? 'user' : _name,
                            style: TextStyle(
                                  color: color,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              print('My name is pressed');
                            }
                        ),
                      ]
                    ),
                     ),
                     const SizedBox(height: 5,),
                     Textwidget(
                    text: _email == null ? 'Email' : _email!,
                    color: color,
                    textSizes: 18,
                    //isTitle: true,
                  ),
                   const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  _listTiles(
                    title: 'Address 2',
                    subtitle: address,
                    icon: IconlyLight.profile,
                    onPressed: () async{
                      await _showAddressDialoge();
                    },
                    color: color
                  ),
                  _listTiles(
                    title: 'Oders',
                    icon: IconlyLight.buy,
                    onPressed: () {
                      GlobalMethods.navigateTo(ctx: context, routeName: OrdersScreen.routeName);
                    },
                    color: color
                  ),
                  _listTiles(
                    title: 'Wishlist',
                    icon: IconlyLight.heart,
                    onPressed: () {
                      GlobalMethods.navigateTo(ctx: context, routeName: WishlistScreen.routeName);
                    },
                    color: color
                  ),
                  _listTiles(
                    title: 'Viewed',
                    icon: IconlyLight.show,
                    onPressed: () {
                      GlobalMethods.navigateTo(ctx: context, routeName: ViewedRecentlyScreen.routeName);
                    },
                    color: color
                  ),
                  SwitchListTile(
                    title:  Textwidget(
                    text: themeState.getDarkTheme? "Dark mode" : "Ligth mode",
                    color: color,
                    textSizes: 18,
                    //isTitle: true,
                   ),
                    secondary: Icon(themeState.getDarkTheme
                        ? Icons.dark_mode_outlined
                        : Icons.light_mode_outlined),
                    onChanged: (bool value) {
                      setState(() {
                        themeState.setDarkTheme = value;
                      });
                    },
                    value: themeState.getDarkTheme,
                  ),
                  _listTiles(
                    title: 'Forget password',
                    icon: IconlyLight.unlock,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const ForgetPasswordScreen()));
                    },
                    color: color
                  ),
                   _listTiles(
                      title: user == null? 'Login' : 'Logout',
                      icon: user == null? IconlyLight.login : IconlyLight.logout,
                      onPressed: () {
                         if (user == null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                          return;
                        }
                        GlobalMethods.WarnigDialog(
                          title: 'Sign out', 
                          subtitle: 'Do you wanna sign out? ', 
                          fct: () async{
                           await authInstance.signOut();
                           Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
                          }, 
                          context: context);
                      },
                      color: color),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> _showAddressDialoge() async{
    await showDialog(
                      context: context, 
                      builder: (context){
                        return AlertDialog(
                          title: const Text('Update'),
                          content: TextField(
                            onChanged: (value) {
                              print('_addressTextController.text ${_addressTextController.text}');
                            },
                            controller: _addressTextController,
                            //maxLines: 5,
                            decoration:const InputDecoration(hintText: "your address"),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () async{
                                String _uid = user!.uid;
                                try {
                                   await FirebaseFirestore.instance.collection('users').doc(_uid).update({
                                    'shipping-adress': _addressTextController.text
                                   });
                                   Navigator.pop(context);
                                   setState(() {
                                     address = _addressTextController.text;
                                   });
                                } catch (error) {
                                  GlobalMethods.errorgDialog(subtitle: error.toString(), context: context);
                                }
                              }, 
                              child:const Text('Update')),
                          ],
                        );
                      });
  }

  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required VoidCallback onPressed,
    required Color color,
  }) {
    

    return ListTile(
      title: Textwidget(text: title, color: color, textSizes: 22, isTitle: true,),
      subtitle:subtitle !=null ? Textwidget(
        text: subtitle, 
        color: color, 
        textSizes: 18) : null,// Apply dynamic color to subtitle
      leading: Icon(icon),
      trailing: const Icon(IconlyLight.arrowRight2),
      onTap: onPressed,
    );
  }
}
