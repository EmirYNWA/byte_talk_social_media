import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:social_media_app/main.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedSplashScreen(
            splash: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.zero,
                child: SizedBox.expand(
                  child: Image.asset(
                    'assets/logo2.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
            nextScreen: const MyHomePage(),
            splashTransition: SplashTransition.fadeTransition,
            pageTransitionType: PageTransitionType.leftToRightWithFade,
          ),

          const Positioned(
            bottom: 300.0,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'LINKAPP',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 270.0,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Link moments, share stories',
                style: TextStyle(
                  fontSize: 16.0,
                  //fontFamily: 'Poppins',
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
