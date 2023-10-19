import 'package:flutter/material.dart';
import 'package:todoapidemo/screens/create.dart';
import 'package:todoapidemo/screens/home.dart';



class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const Duration splashDuration = Duration(seconds: 3);

    Future.delayed(splashDuration, () {
      // After the delay, navigate to the next screen.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) {
          // Replace 'NextScreen' with the screen you want to navigate to.
          return CustomScreen();
        }),
      );
    });

    return Scaffold(
      backgroundColor: Colors.transparent, // Set the background to transparent
      body: Stack(
        children: [

          Container(
            color:Colors.white38,
            child: Center(
              child: Image.asset(
                'images/pngwing.com.png', // Replace with the path to your image asset
                width: 300, // Set the image width
                height: 200, // Set the image height
              ),
            ),
          ),


        ],
      ),
    );
  }
}