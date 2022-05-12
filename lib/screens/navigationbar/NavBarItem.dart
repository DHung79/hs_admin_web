import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hs_admin_web/configs/text_theme.dart';

import '../../configs/themes.dart';

class NavBarItem extends StatefulWidget {
  final String icon;
  final Function? touched;
  final bool active;
  final String title;
  NavBarItem({
    required this.icon,
    this.touched,
    required this.active,
    required this.title,
  });
  @override
  _NavBarItemState createState() => _NavBarItemState();
}

class _NavBarItemState extends State<NavBarItem> {
  @override
  Widget build(BuildContext context) {
    return Material(
      
      color: Colors.white,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        child: InkWell(
          onTap: () {
            print(widget.icon);
            widget.touched!();
          },
          splashColor: Colors.white,
          hoverColor: Colors.white12,
          child: Container(
            padding: const EdgeInsets.all(19),
            child: Row(
              children: [
                SvgPicture.asset(
                  widget.icon,
                  width: 24,
                  height: 24,
                  color:
                      widget.active ? WebColor.testColor3 : WebColor.textColor7,
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  widget.title,
                  style: WebTextTheme().normalText(widget.active
                      ? WebColor.testColor3
                      : WebColor.textColor7),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
