import 'package:flutter/material.dart';
import 'rounded_button.dart';
import '../constants.dart';
import 'chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static String id = 'RegistrationScreen' ;
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String ? email , password ;
 // final  _auth =FirebaseAuth.instance ;
  bool showSpineer = false;

  @override
  void initState() {
    super.initState();
    //https://stackoverflow.com/questions/63492211/no-firebase-app-default-has-been-created-call-firebase-initializeapp-in
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpineer,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'logo',
                child: Container(
                  height: 200.0,
                  child: Image.asset('images/logo.png'),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  //Do something with the user input.
                  email = value ;
                },

                decoration: kTextFelidDecoration.copyWith(
                  hintText: 'Enter your email',
                  ),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true ,
                onChanged: (value) {
                  //Do something with the user input.
                  password = value ;
                },
                decoration: kTextFelidDecoration.copyWith(
                  hintText: 'Enter your password',
                ),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(text: 'Register', color: Colors.blueAccent, onPressed:  () async {
                setState(() {
                  showSpineer =true ;
                });

                try {
                 final user = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email!,
                      password: password!,
                  );

                 if(user!=null){
                   Navigator.pushNamed(context, ChatScreen.id);
                 }

                  setState(() {
                    showSpineer =false ;
                  });

                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    print('The password provided is too weak.');
                  } else if (e.code == 'email-already-in-use') {
                    print('The account already exists for that email.');
                  }
                  else{
                    print(e);
                  }
                  setState(() {
                    showSpineer =false ;
                  });
                }
              },),
            ],
          ),
        ),
      ),
    );
  }
}
