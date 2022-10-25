import 'dart:math';

import 'package:flutter/material.dart';

///秒表
class StopwatchPage extends StatefulWidget {
  @override
  _StopwatchPageState createState() => _StopwatchPageState();
}

class _StopwatchPageState extends State<StopwatchPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          '秒表',
          style: TextStyle(
              fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        // actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.orangeAccent,
        elevation: 1,
        actions: _buildActions(),
      ),
      body: Column(
        children: [_buildStopwatchPanel(), _buildRecordPanel(), _buildTools()],
      ),
    );
  }

  List<Widget> _buildActions() {
    return [
      PopupMenuButton(
        itemBuilder: (context) {
          return [
            PopupMenuItem(
                value: '设置',
                child: Center(
                  child: Text('设置'),
                ))
          ];
        },
        onSelected: _onMenuSelect,
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        icon: Icon(Icons.more_vert_outlined),
      )
    ];
  }

  void _onMenuSelect(String value) {}

  Widget _buildStopwatchPanel() {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      height: width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: width * 0.1 + 15),
      child: CustomPaint(
        painter: StopwatchPainter(
            duration: Duration(minutes: 1, seconds: 10, milliseconds: 100),
            themeColor: Colors.red,
            scaleColor: Colors.blue,
            textStyle: TextStyle(fontSize: 15, color: Colors.black)),
      ),
    );
  }

  Widget _buildRecordPanel() {
    return Expanded(
        child: Container(
      color: Colors.orange,
    ));
  }

  Widget _buildTools() {
    return Container(
      color: Colors.green,
      height: 80,
    );
  }
}

//表盘绘制
class StopwatchPainter extends CustomPainter {
  final Duration duration;
  final Color themeColor;
  final Color scaleColor;
  final TextStyle textStyle;
  final Paint _scalePaint = Paint(); //刻度画笔
  final Paint _indicatorPaint = Paint(); //指示器画笔
  final TextPainter _textPaint = TextPainter(
      textAlign: TextAlign.center, textDirection: TextDirection.ltr); //文字画笔

  StopwatchPainter(
      {required this.duration,
      required this.themeColor,
      required this.scaleColor,
      required this.textStyle}) {
    _scalePaint..style = PaintingStyle.stroke;
    _indicatorPaint.color = themeColor;
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);

    _drawScale(canvas, size);
  }

  //绘制表盘刻度
  void _drawScale(Canvas canvas, Size size) {
    double lineWidth = size.width / 25;
    for (int i = 0; i < 180; i++) {
      if (i == 90 + 45) {
        //起始刻度
        _scalePaint.color = themeColor;
      } else {
        _scalePaint.color = scaleColor;
      }
      canvas.drawLine(Offset(size.width / 2, 0),
          Offset(size.width / 2 - lineWidth, 0), _scalePaint);
      canvas.rotate(pi / 180 * 2);
    }
  }

  void _drawIndicator(Canvas canvas, Size size) {
    int second = duration.inSeconds % 60;
    int millisecond = duration.inMilliseconds % 1000;
    double radians = (second * 1000 + millisecond) / (60 * 1000) * pi;
    canvas.save();
    canvas.rotate(radians);

    // canvas.drawCircle(Offset(dx, dy), radius, _indicatorPaint);
  }

  @override
  bool shouldRepaint(covariant StopwatchPainter oldDelegate) {
    return true;
    // return oldDelegate.duration != duration ||
    //     oldDelegate.themeColor != themeColor ||
    //     oldDelegate.scaleColor != scaleColor ||
    //     oldDelegate.textStyle != textStyle;
  }
}

enum StopwatchType { none, stopped, running }
