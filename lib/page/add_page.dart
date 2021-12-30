import 'package:choice/constant/widget_style.dart';
import 'package:choice/provider/food_provider.dart';
import 'package:choice/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  TextEditingController _foodController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: commonAppbar('加 饭 啦 ！'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(left: 30, right: 30),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1, color: Color(0xFFC7C8D0)))),
              child: TextField(
                controller: _foodController,
                style: WidgetStyle.black16,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    hintText: '在这里输入你想吃的菜品～',
                    hintStyle: WidgetStyle.grey16,
                    border: InputBorder.none),
              )),
          const SizedBox(
            height: 30,
          ),
          Hero(
              tag: 'add',
              child: elevatedBtn('加菜', Colors.green, () => _addFood(context),
                  textStyle: WidgetStyle.white18)),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  void _addFood(BuildContext context) {
    if (_foodController.text.isEmpty) {
      EasyLoading.showToast('先输入你想吃的菜哦～');
      return;
    }

    if (context.read<FoodProvider>().foods.contains(_foodController.text)) {
      EasyLoading.showToast('食谱里已经有这道菜了哦～');
      return;
    }
    context.read<FoodProvider>().addFoods(_foodController.text);
    EasyLoading.showToast('添加成功',
        toastPosition: EasyLoadingToastPosition.bottom);
    Navigator.pop(context, 'true');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _foodController.dispose();
  }
}
