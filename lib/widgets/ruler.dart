library ruler_picker;

import 'package:flutter/material.dart';

/// The controller for the ruler picker
/// init the ruler value from the controller
/// 用于 RulerPicker 的控制器，可以在构造函数里初始化默认值
class RulerPickerController extends ValueNotifier<int> {
  RulerPickerController({int value = 0}) : super(value);
  @override
  int get value => super.value;
  @override
  set value(int newValue) {
    super.value = newValue;
  }
}

typedef ValueChangedCallback = void Function(int value);

class MyRulerPicker extends StatefulWidget {
  final int selectedValue;
  final ValueChangedCallback onValueChange;
  final String Function(int index, int rulerScaleValue)? onBuildRulerScalueText;
  final double width;
  final double height;
  final int beginValue;
  final int endValue;
  final int initValue;
  final TextStyle rulerScaleTextStyle;
  final List<ScaleLineStyle> scaleLineStyleList;
  final Widget? marker;
  final double rulerMarginTop;
  final Color rulerBackgroundColor;
  final RulerPickerController? controller;

  const MyRulerPicker({
    this.selectedValue = 0,
    required this.beginValue,
    required this.endValue,
    required this.onValueChange,
    required this.width,
    required this.height,
    this.rulerMarginTop = 0,
    this.scaleLineStyleList = const [
      ScaleLineStyle(
          scale: 0,
          color: Color.fromARGB(255, 188, 194, 203),
          width: 2,
          height: 32),
      ScaleLineStyle(
          color: Color.fromARGB(255, 188, 194, 203), width: 1, height: 20),
    ],
    this.rulerScaleTextStyle = const TextStyle(
      color: Color.fromARGB(255, 188, 194, 203),
      fontSize: 14,
    ),
    this.marker,
    this.onBuildRulerScalueText,
    this.initValue = 0,
    this.rulerBackgroundColor = Colors.white,
    this.controller,
  }) : assert(endValue > beginValue,
            initValue >= beginValue && initValue <= endValue);
  @override
  State<StatefulWidget> createState() {
    return MyRulerPickerState();
  }
}

class MyRulerPickerState extends State<MyRulerPicker> {
  double lastOffset = 0;
  bool isPosFixed = false;
  int _value = 0;
  // String currentValue = '';
  late ScrollController scrollController;
  final Map<int, ScaleLineStyle> _scaleLineStyleMap = {};

  @override
  void initState() {
    super.initState();

    for (var element in widget.scaleLineStyleList) {
      _scaleLineStyleMap[element.scale] = element;
    }
    // _ruleScaleInterval: 10
    double initValueOffset =
        (widget.initValue - widget.beginValue) * _ruleScaleInterval;
    scrollController = ScrollController(
        initialScrollOffset: initValueOffset > 0 ? initValueOffset : 0);
    // currentValue = widget.initValue.toString();
    scrollController.addListener(() {
      setState(() {
        int currentScale =
            // scrollController.offset ~/ _ruleScaleInterval.toInt();
            scrollController.offset ~/ _ruleScaleInterval.toInt();
        if (currentScale < 0) currentScale = 0;

        int currentValue = currentScale + widget.beginValue;
        if (currentValue > widget.endValue) currentValue = widget.endValue;
        widget.onValueChange(currentValue);
        print(
            "scrollController.offset: ${scrollController.offset}, currentValue: ${_ruleScaleInterval.toInt()}");
        // print("currentScale: ${currentScale}, currentValue: ${currentValue}");
        _value = currentValue;

        // this.currentValue = currentValue.toString();
      });
    });
    widget.controller?.addListener(() {
      if (widget.controller!.value >= widget.beginValue &&
          widget.controller!.value <= widget.endValue) {
        setPositionByValue(widget.controller?.value ?? 0);
      }
    });
  }

  // bool get isFirstOrLast => index == 0 ||
  bool isFirst(int index) {
    if (index == 0) return true;

    return false;
  }

  bool isLast(int index) {
    if (index == (widget.endValue - widget.beginValue)) return true;
    return false;
  }

  Widget _buildRulerScaleLine(int index) {
    double width = 0;
    double height = 0;
    Color color = const Color.fromARGB(255, 188, 194, 203);
    int scale = index % 10;
    final dotItem = _scaleLineStyleMap[scale];

    if (dotItem != null) {
      width = dotItem.width;
      height = dotItem.height;
      color = dotItem.color;
    } else {
      if (_scaleLineStyleMap[-1] != null) {
        scale = -1;
        width = _scaleLineStyleMap[scale]!.width;
        height = _scaleLineStyleMap[scale]!.height;
        color = _scaleLineStyleMap[scale]!.color;
      } else {
        if (scale == 0) {
          width = 2;
          height = 32;
        } else {
          width = 1;
          height = 20;
        }
      }
    }

    return Container(
      width: width,
      height: height,
      // color: color,
      decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.all(Radius.circular(2))),
    );
  }

  Widget _buildRulerScale(BuildContext context, int index) {
    // print('_buildRulerScale:$index, value: ${value}');

    return Container(
      margin: EdgeInsets.only(
          left: isFirst(index) ? (widget.width - _ruleScaleInterval) / 2 : 0,
          right: isLast(index) ? (widget.width - _ruleScaleInterval) / 2 : 0),
      width: _ruleScaleInterval,
      child: Stack(
        clipBehavior: Clip.none,
        children: <Widget>[
          Align(
              alignment: Alignment.bottomCenter,
              child: _buildRulerScaleLine(index)),
          Positioned(
            bottom: _scaleLineStyleMap[0]!.height,
            width: 50,
            left: -25 + _ruleScaleInterval / 2,
            child: index % 10 == 0
                ? Container(
                    alignment: Alignment.center,
                    // color: Colors.pink,
                    child: Text(
                      getRulerScaleText(index),
                      style: widget.rulerScaleTextStyle,
                    ),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }

  final double _ruleScaleInterval = 10;

  void fixOffset() {
    int tempFixedOffset = (scrollController.offset + 0.5) ~/ 1;

    double fixedOffset = (tempFixedOffset + _ruleScaleInterval / 2) ~/
        _ruleScaleInterval.toInt() *
        _ruleScaleInterval;
    Future.delayed(Duration.zero, () {
      scrollController.animateTo(fixedOffset,
          duration: const Duration(milliseconds: 50),
          curve: Curves.bounceInOut);
    });
  }

  String getRulerScaleText(int index) {
    int rulerScaleValue = index + widget.beginValue;
    int currentScale = scrollController.offset ~/ _ruleScaleInterval.toInt();

    if (currentScale < 0) currentScale = 0;

    int currentValue = currentScale + widget.beginValue;
    if (currentValue > widget.endValue) currentValue = widget.endValue;

    // WHEN SCALE TEXT ARE IN RANGE OF [current value -3; current value + 3] then hiddend.
    if (rulerScaleValue > (currentScale - 3) &&
        rulerScaleValue < (currentValue + 3)) {
      return "".toString();
    }

    if (widget.onBuildRulerScalueText == null) {
      return rulerScaleValue.toString();
    }

    return widget.onBuildRulerScalueText!.call(index, rulerScaleValue);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height + widget.rulerMarginTop,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomCenter,
            child: Listener(
              onPointerDown: (event) {
                FocusScope.of(context).requestFocus(FocusNode());
                isPosFixed = false;
              },
              onPointerUp: (event) {},
              child: NotificationListener(
                onNotification: (scrollNotification) {
                  if (scrollNotification is ScrollStartNotification) {
                  } else if (scrollNotification is ScrollUpdateNotification) {
                  } else if (scrollNotification is ScrollEndNotification) {
                    if (!isPosFixed) {
                      isPosFixed = true;
                      fixOffset();
                    }
                  }
                  return true;
                },
                child: Container(
                  width: double.infinity,
                  height: widget.height,
                  color: widget.rulerBackgroundColor,
                  child: ListView.builder(
                    itemCount: widget.endValue - widget.beginValue + 1,
                    controller: scrollController,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: _buildRulerScale,
                  ),
                ),
              ),
            ),
          ),
          widget.marker != null
              ? Align(
                  alignment: Alignment.bottomCenter,
                  child: widget.marker,
                )
              : Container(),
          // BOTTOM-LEFT-OPACITY
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              height: widget.height,
              width: 50,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Colors.white.withOpacity(0.0),
                  Colors.white.withOpacity(1),
                ],
              )),
            ),
          ),
          // BOTTOM-RIGHT-OPACITY
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              // color: Colors.red,
              height: widget.height,
              width: 50,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Colors.white.withOpacity(0.0),
                    Colors.white.withOpacity(1),

                    // Colors.red.withOpacity(0.10),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  void didUpdateWidget(MyRulerPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  /// 根据数值设置标记位置
  void setPositionByValue(int value) {
    double targetValue = (value - widget.beginValue) * _ruleScaleInterval;
    if (targetValue < 0) targetValue = 0;
    scrollController.jumpTo(targetValue.toDouble());
  }
}

class ScaleLineStyle {
  final int scale;
  final int step;
  final Color color;
  final double width;
  final double height;

  const ScaleLineStyle({
    this.scale = -1,
    this.step = 0,
    required this.color,
    required this.width,
    required this.height,
  });
}
