import 'dart:ui';

import 'package:biocare_flutter/screens/base_screen.dart';
import 'package:biocare_flutter/widgets/custom/custom_ruler.dart';
import 'package:biocare_flutter/widgets/ruler.dart';
import 'package:flutter/material.dart';
import 'package:biocare_flutter/widgets/custom/custom_ruler.dart';

class SignInView extends BasePageScreen {
  static const routeName = "/signIn";

  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends BasePageScreenState<SignInView> with BaseScreen {
  final TextEditingController _firstNameController = TextEditingController();
  RulerPickerController? _rulerPickerController;
  int currentValue = 50;
  int currentValue2 = 2500;
  int currentValue3 = 150;
  int currentValue4 = 50;
  String selectType = "height,inch";
  RulerType rulerType1 = RulerType.height;
  RulerType rulerType2 = RulerType.weight;
  UnitType unitType = UnitType.imperial;
  @override
  void initState() {
    // isShowLogo(true);
    super.initState();
    isShowLogo(true);
    _rulerPickerController = RulerPickerController(value: 0);
  }

  @override
  String appBarTitle() {
    return "";
  }

  @override
  void onClickBackButton() {
    // TODO: implement onClickBackButton
  }

  void onClickImperial() {
    print("imetric");
    if (unitType == UnitType.metric) {
      setState(() {
        unitType = UnitType.imperial;
      });
    }
  }

  void onClickMetric() {
    print("metric");
    if (unitType == UnitType.imperial) {
      setState(() {
        unitType = UnitType.metric;
      });
    }
  }

  @override
  List<Widget>? actions() {
    // TODO: implement actions
    return [];
  }

  @override
  Widget body() {
    // TODO: implement body
    final double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return Column(
      children: [
        SizedBox(
          height: statusBarHeight + 60,
        ),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Container(
              color: Colors.pink.shade50,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: onClickImperial,
                          child: Text("Imperial(ft,lb")),
                      ElevatedButton(
                          onPressed: onClickMetric,
                          child: Text("Metric(cm,kg)"))
                    ],
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: const [Text("Height"), Text("feet, inch")],
                  // ),
                  CustomRuler(
                    key: UniqueKey(),
                    onValueChange: (value) {
                      print("custom Value: $value");
                    },
                    rulerType: RulerType.height,
                    unitType: unitType,
                  ),
                  CustomRuler(
                    key: UniqueKey(),
                    onValueChange: (value) {
                      print("custom Value: $value");
                    },
                    rulerType: RulerType.weight,
                    unitType: unitType,
                  ),
                  // CustomRuler(
                  //   onValueChange: (value) {
                  //     print("custom Value: $value");
                  //   },
                  //   rulerType: RulerType.height,
                  //   unitType: UnitType.metric,
                  // ),
                  // CustomRuler(
                  //   onValueChange: (value) {
                  //     print("custom Value: $value");
                  //   },
                  //   rulerType: RulerType.weight,
                  //   unitType: UnitType.metric,
                  // ),
                  // MyRulerPicker(
                  //   width: MediaQuery.of(context).size.width - 32,
                  //   height: 70,
                  //   controller: _rulerPickerController!,
                  //   beginValue: 0,
                  //   endValue: 100,
                  //   initValue: currentValue,
                  //   scaleLineStyleList: const [
                  //     ScaleLineStyle(
                  //         color: Colors.black, width: 2, height: 24, scale: 0),
                  //     ScaleLineStyle(
                  //       color: Colors.black,
                  //       width: 2,
                  //       height: 12,
                  //       scale: -1,
                  //     ),
                  //   ],
                  //   onBuildRulerScalueText: (index, scaleValue) {
                  //     return "${(scaleValue / 10).toInt()}'";
                  //   },
                  //   onValueChange: (value) {
                  //     setState(() {
                  //       currentValue = value;
                  //     });
                  //   },

                  //   // rulerMarginTop: 8,
                  //   marker: Column(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Container(
                  //         // color: Colors.red,
                  //         child: Text(
                  //           "${(currentValue / 10).toInt().toString()}'${(currentValue % 10).toInt().toString()}''",
                  //           style: Theme.of(context).textTheme.headline2,
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         height: 4,
                  //       ),
                  //       Container(
                  //           width: 4,
                  //           height: 30,
                  //           decoration: BoxDecoration(
                  //               color: const Color.fromRGBO(28, 186, 146, 1),
                  //               borderRadius: BorderRadius.circular(5))),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 10),
                  // MyRulerPicker(
                  //   controller: _rulerPickerController!,
                  //   beginValue: 0,
                  //   endValue: 3000,
                  //   initValue: currentValue2,
                  //   scaleLineStyleList: const [
                  //     ScaleLineStyle(
                  //         color: Color.fromARGB(255, 43, 26, 197),
                  //         width: 2,
                  //         height: 14,
                  //         scale: 0),
                  //     ScaleLineStyle(
                  //         color: Color.fromARGB(255, 26, 226, 60),
                  //         width: 2,
                  //         height: 14,
                  //         scale: 5),
                  //     ScaleLineStyle(
                  //         color: Color.fromARGB(255, 69, 47, 47),
                  //         width: 2,
                  //         height: 7,
                  //         scale: -1)
                  //   ],
                  //   onBuildRulerScalueText: (index, scaleValue) {
                  //     return "${(scaleValue / 10).toInt().toString()}";
                  //   },
                  //   onValueChange: (value) {
                  //     setState(() {
                  //       currentValue2 = value;
                  //     });
                  //   },
                  //   width: MediaQuery.of(context).size.width - 32,
                  //   height: 120,
                  //   rulerMarginTop: 8,
                  //   marker: Column(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.all(10),
                  //         child: Container(
                  //           // color: Colors.black,
                  //           child: Text(
                  //             "${(currentValue2 / 10).toString()}",
                  //             style: Theme.of(context).textTheme.headline2,
                  //           ),
                  //         ),
                  //       ),
                  //       ClipPath(
                  //         clipper: TriangleClipper(),
                  //         child: Container(
                  //           color: const Color.fromRGBO(28, 186, 146, 1),
                  //           height: 22,
                  //           width: 9,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // MyRulerPicker(
                  //   controller: _rulerPickerController!,
                  //   beginValue: 0,
                  //   endValue: 600,
                  //   initValue: currentValue3,
                  //   scaleLineStyleList: const [
                  //     ScaleLineStyle(
                  //         color: Color.fromARGB(255, 43, 26, 197),
                  //         width: 2,
                  //         height: 14,
                  //         scale: 0),
                  //     ScaleLineStyle(
                  //         color: Color.fromARGB(255, 26, 226, 60),
                  //         width: 2,
                  //         height: 14,
                  //         scale: 5),
                  //     ScaleLineStyle(
                  //         color: Color.fromARGB(255, 69, 47, 47),
                  //         width: 2,
                  //         height: 7,
                  //         scale: -1)
                  //   ],
                  //   onBuildRulerScalueText: (index, scaleValue) {
                  //     return "${scaleValue.toString()}";
                  //   },
                  //   onValueChange: (value) {
                  //     setState(() {
                  //       currentValue3 = value;
                  //     });
                  //   },
                  //   width: MediaQuery.of(context).size.width - 32,
                  //   height: 120,
                  //   rulerMarginTop: 8,
                  //   marker: Column(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.all(10),
                  //         child: Container(
                  //           // color: Colors.black,
                  //           child: Text(
                  //             "${currentValue3.toString()}",
                  //             style: Theme.of(context).textTheme.headline2,
                  //           ),
                  //         ),
                  //       ),
                  //       ClipPath(
                  //         clipper: TriangleClipper(),
                  //         child: Container(
                  //           color: const Color.fromRGBO(28, 186, 146, 1),
                  //           height: 22,
                  //           width: 9,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // MyRulerPicker(
                  //   controller: _rulerPickerController!,
                  //   beginValue: 0,
                  //   endValue: 200,
                  //   initValue: currentValue4,
                  //   scaleLineStyleList: const [
                  //     ScaleLineStyle(
                  //         color: Color.fromARGB(255, 43, 26, 197),
                  //         width: 2,
                  //         height: 14,
                  //         scale: 0),
                  //     ScaleLineStyle(
                  //         color: Color.fromARGB(255, 26, 226, 60),
                  //         width: 2,
                  //         height: 14,
                  //         scale: 5),
                  //     ScaleLineStyle(
                  //         color: Color.fromARGB(255, 69, 47, 47),
                  //         width: 2,
                  //         height: 7,
                  //         scale: -1)
                  //   ],
                  //   onBuildRulerScalueText: (index, scaleValue) {
                  //     return "${scaleValue.toString()}";
                  //   },
                  //   onValueChange: (value) {
                  //     setState(() {
                  //       currentValue4 = value;
                  //     });
                  //   },
                  //   width: MediaQuery.of(context).size.width - 32,
                  //   height: 120,
                  //   rulerMarginTop: 8,
                  //   marker: Column(
                  //     mainAxisAlignment: MainAxisAlignment.end,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.all(10),
                  //         child: Container(
                  //           // color: Colors.black,
                  //           child: Text(
                  //             "${currentValue4.toString()}",
                  //             style: Theme.of(context).textTheme.headline2,
                  //           ),
                  //         ),
                  //       ),
                  //       ClipPath(
                  //         clipper: TriangleClipper(),
                  //         child: Container(
                  //           color: const Color.fromRGBO(28, 186, 146, 1),
                  //           height: 22,
                  //           width: 9,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
//   @override
//   Widget body() {
//     // TODO: implement body
//     return SafeArea(
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           const SizedBox(
//             height: 80,
//           ),
//           Center(
//               child: Text(
//             "Sign in",
//             style: Theme.of(context)
//                 .textTheme
//                 .headline2
//                 ?.copyWith(color: Theme.of(context).colorScheme.primary),
//           )),
//           ElevatedButton(
//             onPressed: () {},
//             child: Container(
//               alignment: Alignment.center,
//               width: double.infinity,
//               padding: const EdgeInsets.symmetric(
//                 vertical: 10,
//               ),
//               child: Text(
//                 "Sign in",
//                 style: Theme.of(context).textTheme.bodyText2?.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.bold,
//                     ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, size.height / 6);
    path.lineTo(size.width, size.height);
    // path.moveTo(0, size.height);
    // path.lineTo(0, 0);
    // path.lineTo(size.width, size.height);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}
