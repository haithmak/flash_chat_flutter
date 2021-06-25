import 'package:flutter/material.dart';
import 'package:flash_chat_flutter/screens/login_screen.dart';
import 'package:flash_chat_flutter/screens/registration_screen.dart';
import 'rounded_button.dart';
//import 'package:animated_text_kit/animated_text_kit.dart';


class WelcomeScreen extends StatefulWidget {
  static String id = 'WelcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;
  Animation? animation, animationColor;


  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
      // upperBound: 100.0,
    );

    animation = CurvedAnimation(
      parent: animationController!,
      curve: Curves.decelerate,
    );

    // animationColor = ColorTween(
    //   begin: Colors.yellow,
    //   end: Colors.green,
    // ).animate(animationController!);

    //  animationController!.forward();

    // animation!.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     animationController!.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     animationController!.forward();
    //   }
    //   print(status);
    // });
    //
    // animationController!.reverse(from: 1.0);
    // animationController!.addListener(() {
    //   setState(() {
    //   //  print(animationController!.value);
    //    // print(animation!.value);
    //   });
    // });
  }

  @override
  void dispose() {
    super.dispose();
    animationController!.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white , //animationColor!.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height:
                        animation!.value * 100.0, // animationController!.value,
                  ),
                ),
                Text(
                  'Flash Chat',
                  style: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(text: 'Login', color: Colors.lightBlue, onPressed: (){
              Navigator.pushNamed(context, LoginScreen.id);
            },),
            RoundedButton(text: 'Register', color: Colors.blueAccent, onPressed: (){
              Navigator.pushNamed(context, RegistrationScreen.id);
            },),
          ],
        ),
      ),
    );
  }
}

