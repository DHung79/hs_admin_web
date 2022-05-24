import 'package:flutter/material.dart';

import '../../configs/svg_constants.dart';
import '../../configs/text_theme.dart';
import '../../configs/themes.dart';

class SearchWidget extends StatefulWidget {
  bool checkSearch = false;

  SearchWidget({Key? key, required this.checkSearch}) : super(key: key);

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 265,
      child: TextFormField(
        cursorHeight: 20,
        cursorColor: WebColor.textColor7,
        style: WebTextTheme().normalText(WebColor.textColor1),
        decoration: InputDecoration(
          hoverColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Tìm kiếm',
          hintStyle: WebTextTheme().normalText(WebColor.textColor7),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
              ),
              child: SvgIcon(
                SvgIcons.search,
                color: widget.checkSearch
                    ? WebColor.textColor7
                    : WebColor.primaryColor2,
              ),
              onPressed: () {},
            ),
          ),
          suffixIcon: widget.checkSearch
              ? null
              : Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                    ),
                    child: SvgIcon(
                      SvgIcons.close,
                      color: WebColor.otherColor1,
                    ),
                    onPressed: () {
                      setState(() {
                        _searchController.text = '';
                        widget.checkSearch = true;
                      });
                    },
                  ),
                ),
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Tìm kiếm';
          }
          return null;
        },
        onChanged: (String value) {
          setState(() {
            if (_searchController.text.isNotEmpty) {
              widget.checkSearch = false;
            }
          });
        },
        controller: _searchController,
      ),
    );
  }
}
