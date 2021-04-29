import 'package:flutter/material.dart';
import 'package:residential/pages/citySelection_page.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CitySelectionPage(),
          ));
    });

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .2),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Image.asset(
              "assets/images/splashscreen.png",
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.height * .1),
              child: LinearProgressIndicator(),
            )
          ]),
        ),
      ),
    );
  }
}
