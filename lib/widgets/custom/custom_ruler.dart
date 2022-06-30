import 'package:biocare_flutter/screens/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:biocare_flutter/widgets/ruler.dart';

enum RulerType { height, weight }

enum UnitType { imperial, metric }

typedef void ValueChangedCallback(int value);

class CustomRuler extends StatefulWidget {
  final ValueChangedCallback onValueChange;
  final RulerType rulerType;
  final UnitType unitType;

  CustomRuler({
    Key? key,
    this.rulerType = RulerType.height,
    this.unitType = UnitType.metric,
    required this.onValueChange,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CustomRulerState();
}

class _CustomRulerState extends State<CustomRuler> {
  final RulerPickerController _rulerPickerController =
      RulerPickerController(value: 0);
  int currentValue = 50;
  int beginValue = 0;
  int endValue = 100;
  @override
  void initState() {
    super.initState();
    initUnitType(widget.unitType, widget.rulerType);
  }

  void initUnitType(UnitType unitType, RulerType rulerType) {
    switch (widget.rulerType) {
      case RulerType.height:
        switch (unitType) {
          case UnitType.imperial:
            beginValue = 0;
            endValue = 100;
            currentValue = 50;
            break;
          case UnitType.metric:
            beginValue = 0;
            endValue = 350;
            currentValue = 150;
            break;
        }
        break;
      case RulerType.weight:
        switch (unitType) {
          case UnitType.imperial:
            beginValue = 0;
            endValue = 3000;
            currentValue = 1500;
            break;
          case UnitType.metric:
            beginValue = 0;
            endValue = 200;
            currentValue = 50;
            break;
        }
        break;
    }
  }

  List<ScaleLineStyle> _scaleLineStyle(RulerType rulerType) {
    switch (rulerType) {
      case RulerType.height:
        if (widget.unitType == UnitType.imperial) {
          return const [
            ScaleLineStyle(color: Colors.black, width: 2, height: 24, scale: 0),
            ScaleLineStyle(
              color: Colors.black,
              width: 2,
              height: 12,
              scale: -1,
            ),
          ];
        } else {
          return const [
            ScaleLineStyle(color: Colors.black, width: 2, height: 24, scale: 0),
            ScaleLineStyle(color: Colors.black, width: 2, height: 24, scale: 5),
            ScaleLineStyle(color: Colors.black, width: 2, height: 12, scale: -1)
          ];
        }
      case RulerType.weight:
        return const [
          ScaleLineStyle(color: Colors.black, width: 2, height: 14, scale: 0),
          ScaleLineStyle(color: Colors.black, width: 2, height: 14, scale: 5),
          ScaleLineStyle(color: Colors.black, width: 2, height: 7, scale: -1)
        ];
    }
  }

  String _markerText(RulerType rulerType, UnitType unitType) {
    switch (rulerType) {
      case RulerType.height:
        switch (unitType) {
          case UnitType.imperial:
            return "     ${(currentValue ~/ 10).toString()}'${(currentValue % 10).toInt().toString()}''";

          case UnitType.metric:
            return "$currentValue";
        }
      case RulerType.weight:
        switch (widget.unitType) {
          case UnitType.imperial:
            return "${(currentValue / 10)}";

          case UnitType.metric:
            return "$currentValue";
        }
    }
  }

  Widget _rulerMarker(RulerType rulerType, UnitType unitType) {
    switch (rulerType) {
      case RulerType.height:
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // color: Colors.red,
              child: Text(
                _markerText(rulerType, unitType),
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              width: 4,
              height: 30,
              decoration: BoxDecoration(
                color: const Color.fromRGBO(28, 186, 146, 1),
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        );
      case RulerType.weight:
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              // color: Colors.black,
              child: Text(
                _markerText(rulerType, unitType),
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            ClipPath(
              clipper: TriangleClipper(),
              child: Container(
                color: const Color.fromRGBO(28, 186, 146, 1),
                height: 22,
                width: 9,
              ),
            ),
          ],
        );
    }
  }

  String _onBuildRulerScalueText(int index, int scaleValue) {
    switch (widget.rulerType) {
      case RulerType.height:
        switch (widget.unitType) {
          case UnitType.imperial:
            return "${(scaleValue ~/ 10)}'";

          case UnitType.metric:
            return "$scaleValue";
        }
      case RulerType.weight:
        switch (widget.unitType) {
          case UnitType.imperial:
            return "${(scaleValue ~/ 10)}";

          case UnitType.metric:
            return "$scaleValue";
        }
    }
  }

  String _unitTitle(RulerType rulerType, UnitType unitType) {
    switch (rulerType) {
      case RulerType.height:
        switch (unitType) {
          case UnitType.imperial:
            return "feet, inch";
          case UnitType.metric:
            return "cm";
        }
      case RulerType.weight:
        switch (unitType) {
          case UnitType.imperial:
            return "pound";
          case UnitType.metric:
            return "kg";
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.rulerType.name),
            Text(_unitTitle(widget.rulerType, widget.unitType))
          ],
        ),
        MyRulerPicker(
            width: MediaQuery.of(context).size.width - 32,
            height: 70,
            controller: _rulerPickerController,
            beginValue: beginValue,
            endValue: endValue,
            initValue: currentValue,
            scaleLineStyleList: _scaleLineStyle(widget.rulerType),
            onBuildRulerScalueText: (index, scaleValue) {
              return _onBuildRulerScalueText(index, scaleValue);
            },
            onValueChange: (value) {
              setState(() {
                currentValue = value;
                widget.onValueChange.call(value);
              });
            },
            marker: _rulerMarker(widget.rulerType, widget.unitType)),
      ]),
    );
  }
}
