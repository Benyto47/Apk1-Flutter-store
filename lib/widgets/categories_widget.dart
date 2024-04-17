import 'package:apk1/inner_screen/cat_screen.dart';
import 'package:apk1/providers/dark_theme_provider.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key, required this.catText, required this.imgPth, required this.passedColor});

  final String catText, imgPth;
  final Color passedColor;

  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery.of(context).size.width;

    final themeState = Provider.of<DarkThemeProvider>(context);
    final Color color = themeState.getDarkTheme ? Colors.white : Colors.black;

    return InkWell(
      onTap: (){
       Navigator.pushNamed(context, CaregoryScreen.routeName,
            arguments: catText);
      },
      child: Container(
        decoration: BoxDecoration(
          color: passedColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: passedColor.withOpacity(0.7), width: 2)
        ),
        child: Column(children: [
          Container(
            height: _screenWidth * 0.3,
            width: _screenWidth * 0.3,
            decoration:  BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imgPth,),
                fit: BoxFit.fill)),
          ),
          Textwidget(text: catText, color: color, textSizes: 20, isTitle: true,)
        ],
        ),
      ),
    );
  }
}