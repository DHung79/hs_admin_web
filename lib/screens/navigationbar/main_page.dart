import 'package:flutter/material.dart';
import 'package:hs_admin_web/configs/themes.dart';
import 'NavBar.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: WebColor.shapeColor1,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          padding: const EdgeInsets.all(32),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.27,
          color: WebColor.textColor2,
          child: Row(
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: NavBar(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
