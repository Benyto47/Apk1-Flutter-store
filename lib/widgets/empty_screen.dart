import 'package:apk1/inner_screen/feeds_screen.dart';
import 'package:apk1/services/global_methode.dart';
import 'package:apk1/services/utils.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key, required this.imagePath, required this.title, required this.subtitle, required this.buttontext});

  final String imagePath, title, subtitle, buttontext;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final temeState = Utils(context).getTheme;
    Size size = Utils(context).getScreensize;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50,),
              Image.asset(
                imagePath,
                width: double.infinity,
                height: size.height*0.4,),
                const SizedBox(height: 10,),
                const Text(
                  'Whoops!',
                  style:  TextStyle(
                    color: Colors.red,
                    fontSize: 40,
                    fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(
                height: 20,
              ),
                Textwidget(text: title, color: Colors.cyan, textSizes: 20),
                const SizedBox(
                height: 20,
              ),
              Textwidget(
                text: subtitle, 
                color: Colors.cyan, 
                textSizes: 20),
                 SizedBox(
                height: size.height*0.1,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: color, 
                  elevation: 0, 
                  backgroundColor: Theme.of(context).cardColor.withOpacity(1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(
                      color: color,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 35,
                    vertical: 20
                  ),
                ),
                onPressed: (){
                  GlobalMethods.navigateTo(ctx: context, routeName: FeesdScreen.routeName);
                }, 
                child:  Textwidget(
                  text: buttontext, 
                  color:temeState? Colors.grey.shade300 : Colors.grey.shade800, textSizes: 20, 
                  isTitle: true,),
                )

            ],
          ),),
      ),
    );
  }
}