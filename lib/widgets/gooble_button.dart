import 'package:apk1/consts/firebase_const.dart';
import 'package:apk1/fetch_screen.dart';
import 'package:apk1/screen/btm_bar.dart';
import 'package:apk1/services/global_methode.dart';
import 'package:apk1/widgets/text_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);


  Future<void> _googleSignIn(context) async{
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();

    if(googleAccount != null ){
      final googleAuth = await googleAccount.authentication;
      
      if(googleAuth.accessToken != null && googleAuth.idToken != null){
        try{
        final authResult =  await authInstance.signInWithCredential(
            GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken
            )
          );
        if(authResult.additionalUserInfo!.isNewUser){
          await FirebaseFirestore.instance.collection('users').doc(authResult.user!.uid).set({
            'id': authResult.user!.uid,
            'name': authResult.user!.displayName,
            'email': authResult.user!.email,
            'shipping-adress': '',
            'userWish': [],
            'userCart': [],
            'createdAt': Timestamp.now(),
          });
        }

           Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const FetchScreen()));

      }on FirebaseException catch (error){
        GlobalMethods.errorgDialog(subtitle: '${error.message}', context: context);
      }catch(error){
        GlobalMethods.errorgDialog(subtitle: '$error', context: context);
      }finally{

      }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue,
      child: InkWell(
        onTap: () {
          _googleSignIn(context);
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            color: Colors.white,
            child: Image.asset(
              'assets/images/google.png',
              width: 40.0,
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Textwidget(
              text: 'Sign in with google', color: Colors.white, textSizes: 18)
        ]),
      ),
    );
  }
}
