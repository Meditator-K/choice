import 'package:choice/constant/data_keys.dart';
import 'package:choice/util/sp_util.dart';
import 'package:flutter/material.dart';

class FoodProvider extends ChangeNotifier {
  List<String> _foods = [];

  List<String> get foods => _foods;

  void getFoods() {
    SpUtil.getStrList(DataKeys.FOODS).then((value) {
      if (value == null || value.isEmpty) {
        _foods = [
          '重庆小面',
          '东北水饺',
          '炒河粉',
          '鱼',
          '火锅',
          '兰州拉面',
          '粉丝汤',
          '肠粉',
          '西兰花炒肉',
          '西红柿炒鸡蛋',
          '疙瘩汤',
          '土豆丝',
          '喝粥',
          '螺蛳粉',
        ];
        SpUtil.putStrList(DataKeys.FOODS, _foods);
      } else {
        _foods = value;
      }
    });
  }

  void addFoods(String newFood) {
    _foods.add(newFood);
    SpUtil.putStrList(DataKeys.FOODS, _foods);
    notifyListeners();
  }

  void deleteFoods(String food) {
    _foods.remove(food);
    SpUtil.putStrList(DataKeys.FOODS, _foods);
    notifyListeners();
  }
}
