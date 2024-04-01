import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlobalMethods{
  static navigateTo({required BuildContext ctx, required String routeName}){
      Navigator.pushNamed(ctx, routeName);
  }

  static Future<void> WarnigDialog({
    required String title,
    required String subtitle,
    required Function fct, 
    required BuildContext context 
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 8,
                ),
                 Text(title)
              ],
            ),
            content:  Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Textwidget(
                      text: 'Cancel', color: Colors.cyan, textSizes: 18)),
              TextButton(
                  onPressed: () {
                    fct();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child:
                      Textwidget(text: 'Ok', color: Colors.red, textSizes: 18)),
            ],
          );
        });
  }

  
  static Future<void> errorgDialog(
      {
      required String subtitle,
      required BuildContext context}) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                Image.asset(
                  'assets/images/warning-sign.png',
                  height: 20,
                  width: 20,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text('An Error occured')
              ],
            ),
            content: Text(subtitle),
            actions: [
              TextButton(
                  onPressed: () {
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  child: Textwidget(
                      text: 'Ok', color: Colors.cyan, textSizes: 18)),
            ],
          );
        });
  }
}