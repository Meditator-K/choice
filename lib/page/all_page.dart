import 'package:choice/constant/widget_style.dart';
import 'package:choice/provider/food_provider.dart';
import 'package:choice/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class AllPage extends StatefulWidget {
  @override
  _AllPageState createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Hero(
            tag: 'foodList',
            child: Text(
              '查看菜单',
              style: WidgetStyle.title18Bold,
            )),
        automaticallyImplyLeading: true,
        elevation: 3,
        centerTitle: true,
        backgroundColor: Colors.amber,
        iconTheme: IconThemeData(color: Colors.black),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
        actions: [
          GestureDetector(
              onTap: () {
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    _isEditing ? '完成' : '编辑',
                    style: WidgetStyle.lightBlack14Bold,
                  ))),
          SizedBox(
            width: 15,
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Consumer<FoodProvider>(
          builder: (context, foodProvider, _) {
            return Wrap(
              spacing: 10,
              runSpacing: 18,
              children: foodProvider.foods
                  .map((item) => Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: EdgeInsets.fromLTRB(8, 5, 8, 5),
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                                color: WidgetStyle.getRandomColor(),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8))),
                            child: Text(
                              item,
                              style: WidgetStyle.white14,
                            ),
                          ),
                          _isEditing
                              ? InkWell(
                                  onTap: () =>
                                      _deleteFood(context, item, foodProvider),
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.black,
                                    size: 18,
                                  ),
                                )
                              : Container(),
                        ],
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }

  void _deleteFood(context, String item, FoodProvider foodProvider) {
    showAlertDialog(context, '确定要删除这道菜吗？', onConfirm: () {
      foodProvider.deleteFoods(item);
      EasyLoading.showToast('删除成功');
    });
  }
}
