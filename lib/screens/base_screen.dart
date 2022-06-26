import 'package:flutter/material.dart';

abstract class BasePageScreen extends StatefulWidget {
  const BasePageScreen({Key? key}) : super(key: key);
}

abstract class BasePageScreenState<Page extends BasePageScreen>
    extends State<Page> {
  bool _isBack = true;
  bool _isShowLogo = false;

  String appBarTitle();

  List<Widget>? actions();

  void onClickBackButton();

  void isBackButton(bool isBack) {
    _isBack = isBack;
  }

  void isShowLogo(bool isShowLogo) {
    _isShowLogo = isShowLogo;
  }
}

mixin BaseScreen<Page extends BasePageScreen> on BasePageScreenState<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80,
        leading: _isBack
            ? Container(
                alignment: Alignment.topCenter,
                child: IconButton(
                  onPressed: () => onClickBackButton(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
              )
            : null,
        flexibleSpace: _isShowLogo
            ? Container(
                alignment: Alignment.bottomCenter,
                child: const Image(
                  height: 40,
                  width: 40,
                  image: AssetImage("assets/pngs/logo.png"),
                ),
              )
            : null,
        backgroundColor: Colors.transparent,
        title: Text(
          appBarTitle(),
        ),
        actions: actions()?.toList(),
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/pngs/background.png"),
                fit: BoxFit.fill),
          ),
        ),
        body(),
      ]),
    );
  }

  Widget body();
}
