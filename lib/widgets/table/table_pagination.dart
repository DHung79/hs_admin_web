import 'package:flutter/material.dart';
import '/theme/app_theme.dart';
import '../../core/base/models/common_model.dart';

enum PagingButtonStyle { first, previous, number, next, last }

class TablePagination extends StatelessWidget {
  final Function(int) onFetch;
  final Paging pagination;
  final bool onLeft;
  final Widget? leading;
  final Widget? trailing;
  const TablePagination({
    Key? key,
    required this.onFetch,
    required this.pagination,
    this.onLeft = false,
    this.leading,
    this.trailing,
  }) : super(key: key);

  final double _buttonSize = 44;

  @override
  Widget build(BuildContext context) {
    // final pages = pagesList();
    // if (pages.isEmpty) {
    //   return const SizedBox();
    // }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!onLeft) leading ?? const Spacer(),
          Container(
            decoration: BoxDecoration(
              color: AppColor.shade2,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                // if (pagination.totalPage > 5)
                //   _pageButtonFor(style: PagingButtonStyle.first, context: context),
                _pageButtonFor(
                    style: PagingButtonStyle.previous, context: context),
                _pageButtonFor(
                  style: PagingButtonStyle.number,
                  index: pagination.page,
                  context: context,
                ),
                _pageButtonFor(style: PagingButtonStyle.next, context: context),
                // if (pagination.totalPage > 5)
                //   _pageButtonFor(style: PagingButtonStyle.last, context: context),
              ],
            ),
          ),
          if (onLeft) trailing ?? const Spacer(),
        ],
      ),
    );
  }

  List<int> pagesList() {
    if (pagination.totalPage <= 5) {
      return [for (var i = 1; i <= pagination.totalPage; i += 1) i];
    }
    var min = pagination.page - 2 > 0 ? pagination.page - 2 : 1;
    var max = min + 4 <= pagination.totalPage ? min + 4 : pagination.totalPage;
    min = max == pagination.totalPage ? max - 4 : min;
    return [for (int i = min; i <= max; i++) i];
  }

  Widget _pageButtonFor({
    int? index,
    required PagingButtonStyle style,
    required BuildContext context,
  }) {
    return AppButtonTheme.fillRounded(
      constraints: BoxConstraints(
        minHeight: _buttonSize,
        maxWidth: _buttonSize,
      ),
      borderRadius: BorderRadius.circular(10),
      color: _buttonColor(
        index: index,
        style: style,
        context: context,
      ),
      child: _buttonContent(
        index: index,
        style: style,
        context: context,
      ),
      onPressed: _actionFor(style, index),
    );
  }

  _actionFor(PagingButtonStyle style, int? index) {
    switch (style) {
      case PagingButtonStyle.next:
        if (_isEnabled(style)) return () => onFetch(pagination.nextPage);
        break;
      case PagingButtonStyle.previous:
        if (_isEnabled(style)) return () => onFetch(pagination.previousPage);
        break;
      case PagingButtonStyle.first:
        if (_isEnabled(style)) return () => onFetch(1);
        break;
      case PagingButtonStyle.last:
        if (_isEnabled(style)) return () => onFetch(pagination.totalPage);
        break;
      default:
        return null;
    }
    return null;
  }

  Widget _buttonContent({
    int? index,
    required PagingButtonStyle style,
    required BuildContext context,
  }) {
    switch (style) {
      case PagingButtonStyle.next:
      case PagingButtonStyle.previous:
      case PagingButtonStyle.first:
      case PagingButtonStyle.last:
        final color = _isEnabled(style) ? AppColor.black : AppColor.inactive1;
        return Center(child: _iconFor(style, color));
      default:
        final textStyle = pagination.page == index
            ? AppTextTheme.normalText(AppColor.black)
            : AppTextTheme.normalText(AppColor.inactive1);
        return Text(index.toString(), style: textStyle);
    }
  }

  Widget _iconFor(PagingButtonStyle style, Color color) {
    switch (style) {
      case PagingButtonStyle.next:
        return Icon(
          Icons.arrow_forward_ios_outlined,
          color: color,
          size: 20,
        );
      case PagingButtonStyle.previous:
        return Icon(
          Icons.arrow_back_ios_outlined,
          color: color,
          size: 20,
        );
      case PagingButtonStyle.first:
        return Icon(
          Icons.first_page,
          color: color,
          size: 24,
        );
      case PagingButtonStyle.last:
        return Icon(
          Icons.last_page,
          color: color,
          size: 24,
        );
      default:
        return const SizedBox();
    }
  }

  Color _buttonColor({
    required PagingButtonStyle style,
    int? index,
    required BuildContext context,
  }) {
    final iconColor = _isEnabled(style) ? AppColor.white : AppColor.transparent;
    switch (style) {
      case PagingButtonStyle.next:
        return iconColor;
      case PagingButtonStyle.previous:
        return iconColor;
      case PagingButtonStyle.first:
        return iconColor;
      case PagingButtonStyle.last:
        return iconColor;
      default:
        return AppColor.transparent;
    }
  }

  bool _isEnabled(PagingButtonStyle style) {
    switch (style) {
      case PagingButtonStyle.previous:
        return pagination.canGoPrevious;
      case PagingButtonStyle.next:
        return pagination.canGoNext;
      case PagingButtonStyle.first:
        return pagination.page > 1;
      case PagingButtonStyle.last:
        return pagination.page < pagination.totalPage;
      default:
        return false;
    }
  }
}
