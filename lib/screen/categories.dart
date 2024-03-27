import 'package:apk1/widgets/categories_widget.dart';
import 'package:apk1/services/utils.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class CategorisesScreen extends StatelessWidget {
   CategorisesScreen({super.key});

   List<Color> gridColors = [
    const Color(0xff53B175),
    const Color(0xffF8A44C),
    const Color(0xffF7A593),
    const Color(0xffD3B0E0),
    const Color(0xffFDE598),
    const Color(0xffB7DFF5),
  ];

List<Map<String, dynamic>> catInfo = [
    {
      'imgPath': 'assets/images/cat/fruits.png',
      'catText': 'Fruits',
    },
    {
      'imgPath': 'assets/images/cat/veg.png',
      'catText': 'Vegetables',
    },
    {
      'imgPath': 'assets/images/cat/Spinach.png',
      'catText': 'Herbs',
    },
    {
      'imgPath': 'assets/images/cat/nuts.png',
      'catText': 'Nuts',
    },
    {
      'imgPath': 'assets/images/cat/spices.png',
      'catText': 'Spices',
    },
     {
      'imgPath': 'assets/images/cat/grains.png',
      'catText': 'Grains',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final utils = Utils(context);
    Color color = utils.color;

    return  Scaffold(
      appBar: AppBar(
      elevation: 0,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      title: Textwidget(
        text: 'Categories', 
        color: color, 
        textSizes: 24, 
        isTitle: true,),),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 240/250,
          crossAxisSpacing: 10,//vertical spacing
          mainAxisSpacing: 15, //horizontal spacing
          children: List.generate(6, (index){
            return CategoriesWidget(
              catText: catInfo[index]['catText'],
              imgPth: catInfo[index]['imgPath'],
              passedColor: gridColors[index],
            );
          },
          )),
      )
    );
  }
}
