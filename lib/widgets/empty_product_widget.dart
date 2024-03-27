import 'package:apk1/services/utils.dart';
import 'package:flutter/cupertino.dart';

class EmptyProdWidget extends StatelessWidget {
  const EmptyProdWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    Color color = Utils(context).color;
    return Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset('assets/images/box.png'),
              ),
              Text( 
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: color, fontSize: 30, fontWeight: FontWeight.w700),),
            ],
          ),
        ),
      ) ;
  }
}