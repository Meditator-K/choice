import 'dart:async';
import 'dart:math';

import 'package:choice/constant/widget_style.dart';
import 'package:choice/page/add_page.dart';
import 'package:choice/page/all_page.dart';
import 'package:choice/provider/food_provider.dart';
import 'package:choice/util/navigator_util.dart';
import 'package:choice/util/timer_util.dart';
import 'package:choice/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isBack = false;
  String _food = '';
  String _btnText = '今天吃什么';
  TimerUtil _timerUtil = TimerUtil(mTotalTime: 60000, mInterval: 50);
  String _backgroundPath = 'images/bg4.jpeg';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: commonAppbar('开 饭 啦 ！',
            actionWidget: PopupMenuButton(
                itemBuilder: (context) => _actionItem(),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                onSelected: (value) {
                  if (value == 'value1') {
                    _changeImage();
                  }
                },
                child: Icon(
                  Icons.more_horiz,
                  color: Colors.black,
                  size: 28,
                ))),
        body: Consumer<FoodProvider>(
          builder: (context, foodProvider, _) {
            return Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(_backgroundPath), fit: BoxFit.cover)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          _food,
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: WidgetStyle.getRandomColor()),
                        )),
                    const SizedBox(
                      height: 100,
                    ),
                    elevatedBtn(_btnText, Colors.orange,
                        () => _doChoice(foodProvider.foods)),
                    const SizedBox(
                      height: 50,
                    ),
                    Hero(
                        tag: 'foodList',
                        child: elevatedBtn('查看菜单', Colors.green,
                            () => NavigatorUtil.push(context, AllPage()))),
                    const SizedBox(
                      height: 150,
                    ),
                  ],
                ));
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, size: 25, color: Colors.white),
          backgroundColor: Colors.blueAccent,
          heroTag: 'add',
          onPressed: () => _addFood(context),
        ),
      ),
      onWillPop: _onBack,
    );
  }

  List<PopupMenuItem> _actionItem() {
    return <PopupMenuItem<String>>[
      PopupMenuItem(
        value: 'value1',
        child: Text(
          '换个背景',
          style: TextStyle(color: Colors.black, fontSize: 14),
        ),
      ),
    ];
  }

  void _changeImage() async {
    int index = Random().nextInt(15);
    setState(() {
      _backgroundPath = 'images/bg$index.jpeg';
    });
  }

  void _doChoice(List<String> foods) {
    if (_btnText == '今天吃什么') {
      setState(() {
        _btnText = '停';
      });
      _getRandomFood(foods);
    } else {
      setState(() {
        _btnText = '今天吃什么';
      });
      _timerUtil.cancel();
    }
  }

  void _getRandomFood(List<String> foods) {
    _timerUtil.startCountDown();
    _timerUtil.setOnTimerTickCallback((value) {
      setState(() {
        _food = foods[Random().nextInt(foods.length)];
      });
    });
  }

  void _addFood(context) async {
    NavigatorUtil.push(context, AddPage());
  }

  //监听返回键，按两次退出程序
  Future<bool> _onBack() {
    if (!_isBack) {
      _isBack = true;
      EasyLoading.showToast('再按一次就退出了哦');
      Future.delayed(Duration(seconds: 2), () {
        _isBack = false;
      });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timerUtil.cancel();
  }
}
