import 'package:flutter/material.dart';
import 'package:hs_admin_web/configs/svg_constants.dart';
import 'package:hs_admin_web/configs/text_theme.dart';

import '../../configs/themes.dart';

class AppBarWidget extends StatefulWidget {
  final void Function() showProfile;
  final String title;
  final String name;

  const AppBarWidget(
      {Key? key,
      required this.showProfile,
      required this.title,
      required this.name})
      : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      color: Colors.transparent,
      child: Row(
        children: [
          _leftAppBar(title: widget.title, name: widget.name),
          _rightAppBar(),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      ),
    );
  }

  _leftAppBar({required String title, required String name}) {
    return Row(
      children: [
        Text(
          name,
          style: WebTextTheme().mediumHeaderAndTitle(
            WebColor.textColor1,
          ),
        ),
        const SizedBox(
          width: 24,
        ),
        Text(
          title,
          style: WebTextTheme().normalText(
            WebColor.textColor7,
          ),
        ),
      ],
    );
  }

  _rightAppBar() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
            ),
            onPressed: () {},
            child: SvgIcon(
              SvgIcons.comment,
              color: WebColor.textColor7,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: Size.zero,
            ),
            onPressed: () {},
            child: SvgIcon(
              SvgIcons.bell,
              color: WebColor.textColor7,
            ),
          ),
        ),
        _profile(name: 'Hoàng Phi', image: 'assets/images/logo.png'),
      ],
    );
  }

  _profile({required String name, required String image}) {
    return InkWell(
      onTap: widget.showProfile,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            Text(
              name,
              style: WebTextTheme().normalText(
                WebColor.textColor1,
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            CircleAvatar(
              radius: 12,
              backgroundImage: NetworkImage(image),
            )
          ],
        ),
      ),
    );
  }
}
