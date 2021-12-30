import 'package:choice/page/home_page.dart';
import 'package:choice/provider/food_provider.dart';
import 'package:choice/util/navigator_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      Provider.of<FoodProvider>(context, listen: false).getFoods();
    });
    countDown();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Image.asset(
      'images/splash.png',
      fit: BoxFit.cover,
    );
  }

  void countDown() {
    Future.delayed(Duration(seconds: 2), () {
      NavigatorUtil.pushAndRemoveUntil(context, HomePage());
    });
  }
}
