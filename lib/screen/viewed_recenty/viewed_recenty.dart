import 'package:apk1/screen/viewed_recenty/viewed_widget.dart';
import 'package:apk1/services/global_methode.dart';
import 'package:apk1/widgets/back_widget.dart';
import 'package:apk1/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../../services/utils.dart';
import '../../widgets/text_widget.dart';

class ViewedRecentlyScreen extends StatefulWidget {
  static const routeName = '/ViewedRecentlyScreen';

  const ViewedRecentlyScreen({Key? key}) : super(key: key);

  @override
  _ViewedRecentlyScreenState createState() => _ViewedRecentlyScreenState();
}

class _ViewedRecentlyScreenState extends State<ViewedRecentlyScreen> {
  bool check = true;
  @override
  Widget build(BuildContext context) {
    bool _isEmpty = true;
    Color color = Utils(context).color;
    // Size size = Utils(context).getScreenSize;
    return _isEmpty == true
        ? const EmptyScreen(
            title: 'Your history is empty',
            subtitle: 'No products has been viewed yet! :',
            buttontext: 'shop now',
            imagePath: 'assets/images/history.png',
          )
        :  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              GlobalMethods.WarnigDialog(
                  title: 'Empty your history?',
                  subtitle: 'Are you sure?',
                  fct: () {},
                  context: context);
            },
            icon: Icon(
              IconlyBroken.delete,
              color: color,
            ),
          )
        ],
        leading: const BackWidget(),
        automaticallyImplyLeading: false,
        elevation: 0,
        centerTitle: true,
        title: Textwidget(
          text: 'History',
          color: color,
          textSizes: 24.0,
        ),
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
              child: ViewedRecentlyWidget(),
            );
          }),
    );
  }
}
