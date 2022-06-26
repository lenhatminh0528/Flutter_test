import 'dart:ui';

import 'package:biocare_flutter/screens/base_screen.dart';
import 'package:biocare_flutter/widgets/ruler.dart';
import 'package:flutter/material.dart';

class SignInView extends BasePageScreen {
  static const routeName = "/signIn";

  const SignInView({Key? key}) : super(key: key);

  @override
  State<SignInView> createState() => _SignInViewState();
}

enum rulerType { one, two }

class _SignInViewState extends BasePageScreenState<SignInView> with BaseScreen {
  final TextEditingController _firstNameController = TextEditingController();
  RulerPickerController? _rulerPickerController;
  int currentValue = 50;
  int currentValue2 = 50;
  String selectType = "height,inch";
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
                          onPressed: () {}, child: Text("height,inch")),
                      ElevatedButton(onPressed: () {}, child: Text("cm,kg"))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Height"), Text("cm")],
                  ),
                  MyRulerPicker(
                    width: MediaQuery.of(context).size.width - 32,
                    height: 70,
                    controller: _rulerPickerController!,
                    beginValue: 0,
                    endValue: 200,
                    initValue: currentValue,
                    scaleLineStyleList: const [
                      ScaleLineStyle(
                          color: Colors.black, width: 2, height: 24, scale: 0),
                      ScaleLineStyle(
                        color: Colors.black,
                        width: 2,
                        height: 12,
                        scale: -1,
                      ),
                    ],
                    // onBuildRulerScalueText: (index, scaleValue) {
                    //   return ''.toString();
                    // },
                    onValueChange: (value) {
                      setState(() {
                        currentValue = value;
                      });
                    },

                    // rulerMarginTop: 8,
                    marker: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          // color: Colors.red,
                          child: Text(
                            currentValue.toString(),
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
                                borderRadius: BorderRadius.circular(5))),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyRulerPicker(
                    controller: _rulerPickerController!,
                    beginValue: 0,
                    endValue: 300,
                    initValue: currentValue,
                    scaleLineStyleList: const [
                      ScaleLineStyle(
                          color: Color.fromARGB(255, 43, 26, 197),
                          width: 2,
                          height: 14,
                          scale: 0),
                      ScaleLineStyle(
                          color: Color.fromARGB(255, 26, 226, 60),
                          width: 2,
                          height: 14,
                          scale: 5),
                      ScaleLineStyle(
                          color: Color.fromARGB(255, 69, 47, 47),
                          width: 2,
                          height: 7,
                          scale: -1)
                    ],
                    // onBuildRulerScalueText: (index, scaleValue) {
                    //   return ''.toString();
                    // },
                    onValueChange: (value) {
                      setState(() {
                        currentValue2 = value;
                      });
                    },
                    width: MediaQuery.of(context).size.width - 32,
                    height: 120,
                    rulerMarginTop: 8,
                    marker: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Container(
                            // color: Colors.black,
                            child: Text(
                              currentValue2.toString(),
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            // child: BackdropFilter(
                            //   filter:
                            //       ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                            //   child: Text(
                            //     currentValue2.toString(),
                            //     style: Theme.of(context).textTheme.headline2,
                            //   ),
                            // ),
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
                    ),
                  ),
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
