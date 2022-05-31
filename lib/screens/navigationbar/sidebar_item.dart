import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/logger/logger.dart';

import '../../theme/app_theme.dart';

class SideBarButton extends StatefulWidget {
  final SvgIconData icon;
  final Function()? onPressed;
  final bool active;
  final String title;
  const SideBarButton({Key? key, 
    required this.icon,
    this.onPressed,
    required this.active,
    required this.title,
  }) : super(key: key);
  @override
  _SideBarButtonState createState() => _SideBarButtonState();
}

class _SideBarButtonState extends State<SideBarButton> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(bottom: 16.0),
        child: InkWell(
          splashFactory: NoSplash.splashFactory,
          onTap: widget.onPressed,
          // splashColor: Colors.white,
          highlightColor: Colors.transparent,
          hoverColor: Colors.white12,
          child: Container(
            padding: const EdgeInsets.all(19),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4),
                  child: SvgIcon(
                    widget.icon,
                    size: 20,
                    color: widget.active
                        ? AppColor.text3
                        : AppColor.text7,
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
                Text(
                  widget.title,
                  style: AppTextTheme.normalText(widget.active
                      ? AppColor.text3
                      : AppColor.text7),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
