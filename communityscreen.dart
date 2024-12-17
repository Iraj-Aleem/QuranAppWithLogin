  import 'package:flutter/material.dart';
       class CommunityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black, // Set background color to black
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 192, // Adjust the width of the container
              height: 204, // Adjust the height of the container
              child: Image.asset('images/logo.png'), // Replace 'images/logo.png' with the path to your logo image
            ),
            SizedBox(height: 20), // Add some space between the logo and text
            Text(
              'Welcome to \nAl-Quran App',
              style: TextStyle(color: Colors.amber,fontWeight: FontWeight.bold,
                              fontSize: 24.0,),
               
            ),
          ],
        ),
      ),
    );
  }
}