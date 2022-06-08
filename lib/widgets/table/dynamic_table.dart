import 'dart:math';
import 'package:flutter/material.dart';
import 'package:hs_admin_web/widgets/joytech_components/jt_indicator.dart';
import '../../core/base/blocs/block_state.dart';
import 'nested_scroll_fix.dart';
import '../../main.dart';
import '../../theme/app_theme.dart';
import 'table_component.dart';

class DynamicTable extends StatefulWidget {
  final int numberOfRows;
  final TableRow Function(int) rowBuilder;
  final EdgeInsetsGeometry contentPadding;
  final List<TableHeader> columnWidthRatio;
  final bool hasSeparator;
  final BorderSide? separatorSide;
  final bool hideHeaderSection;
  final Widget Function(BuildContext, String)? columnHeaderBuilder;
  final TableCellVerticalAlignment verticalAlignment;
  final bool hasBodyData;
  final bool isSearch;
  final BoxBorder? tableBorder;
  final TextStyle? headerStyle;
  final Color? headerColor;
  final TableBorder? headerBorder;
  final Color? bodyColor;
  final TableBorder? bodyBorder;
  final Widget? Function(BuildContext, String)? getHeaderButton;
  final double headerHeight;
  final MainAxisAlignment headerButtonAlignment;
  final Stream<BlocState> blocState;
  const DynamicTable({
    Key? key,
    required this.columnWidthRatio,
    required this.numberOfRows,
    required this.rowBuilder,
    this.contentPadding = EdgeInsets.zero,
    this.hasSeparator = false,
    this.separatorSide,
    this.hideHeaderSection = false,
    this.columnHeaderBuilder,
    this.verticalAlignment = TableCellVerticalAlignment.middle,
    required this.hasBodyData,
    this.tableBorder,
    this.headerStyle,
    this.headerColor,
    this.headerBorder,
    this.bodyColor,
    this.bodyBorder,
    this.getHeaderButton,
    this.headerHeight = 52,
    this.headerButtonAlignment = MainAxisAlignment.start,
    required this.blocState,
    this.isSearch = false,
  }) : super(key: key);

  @override
  State<DynamicTable> createState() => _DynamicTableState();
}

class _DynamicTableState extends State<DynamicTable> {
  final _centerHeaders = [];
  final _rightHeaders = [];
  final _tableScrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, size) {
        final columnWidths = _buildColumnWidths(size: size);
        return Stack(
          children: [
            Container(
              width: size.maxWidth,
              decoration: BoxDecoration(
                color: widget.bodyColor ?? AppColor.shade2,
                border: widget.tableBorder ??
                    Border.all(
                      color: AppColor.transparent,
                    ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: widget.headerColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(20),
                      ),
                    ),
                    height: widget.headerHeight,
                  ),
                ],
              ),
            ),
            Scrollbar(
              controller: _tableScrollController,
              child: Container(
                decoration: BoxDecoration(
                  border: widget.tableBorder ??
                      Border.all(
                        color: AppColor.transparent,
                      ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColor.shadow.withOpacity(0.16),
                      blurRadius: 16,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  controller: _tableScrollController,
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      if (!widget.hideHeaderSection) _buildHeader(columnWidths),
                      _buildBody(columnWidths),
                    ],
                  ),
                ),
              ),
            ).fixNestedDoubleScrollbar(),
          ],
        );
      },
    );
  }

  _buildColumnWidths({required BoxConstraints size}) {
    Map<int, FixedColumnWidth> _columnWidths = {};
    double totalUnits = 0;
    double totalConstant = 0;

    for (var item in widget.columnWidthRatio) {
      totalUnits += item.isConstant ? 0 : item.width;
      totalConstant += item.isConstant ? item.width : 0;
    }
    final width = size.maxWidth;
    var unit = ((width - totalConstant) / totalUnits);
    for (int i = 0; i < widget.columnWidthRatio.length; i++) {
      final pattern = widget.columnWidthRatio[i];
      var value = pattern.isConstant
          ? pattern.width
          : max(unit * pattern.width, pattern.width) - 2;
      _columnWidths[i] = FixedColumnWidth(value);
    }
    return _columnWidths;
  }

  Widget _buildHeader(Map<int, TableColumnWidth>? columnWidths) {
    return Table(
      border: widget.headerBorder ??
          TableBorder(
            verticalInside: BorderSide(
              color: AppColor.shade1,
            ),
            bottom: BorderSide(
              color: AppColor.shade1,
            ),
          ),
      columnWidths: columnWidths,
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: _buildColumns(
        context: context,
        headers: widget.columnWidthRatio.map((e) => e.title).toList(),
      ),
    );
  }

  Widget _buildBody(Map<int, TableColumnWidth>? columnWidths) {
    return StreamBuilder(
        stream: widget.blocState,
        builder: (context, state) {
          if (!state.hasData || state.data == BlocState.fetching) {
            return Container(
              constraints: const BoxConstraints(minHeight: 40),
              child: Padding(
                padding: widget.contentPadding,
                child: SizedBox(
                  height: 82,
                  child: Center(
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(10),
                          child: JTIndicator(),
                        ),
                        Text(
                          ScreenUtil.t(I18nKey.isLoading)!,
                          style: AppTextTheme.mediumBodyText(AppColor.text8),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }
          return widget.hasBodyData
              ? Padding(
                  padding: widget.contentPadding,
                  child: _buildBodyContent(columnWidths),
                )
              : Container(
                  constraints: const BoxConstraints(minHeight: 40),
                  child: Padding(
                    padding: widget.contentPadding,
                    child: SizedBox(
                      height: 82,
                      child: Center(
                        child: Text(
                          widget.isSearch
                              ? ScreenUtil.t(I18nKey.noSearchResults)!
                              : ScreenUtil.t(I18nKey.noData)!,
                          style: AppTextTheme.mediumBodyText(AppColor.text8),
                        ),
                      ),
                    ),
                  ),
                );
        });
  }

  Widget _buildBodyContent(Map<int, TableColumnWidth>? columnWidths) {
    return widget.hasSeparator
        ? Column(
            children: [
              for (int i = 0; i < widget.numberOfRows; i++)
                Table(
                  border: widget.bodyBorder ??
                      TableBorder(
                        verticalInside: BorderSide(
                          color: AppColor.shade1,
                        ),
                        horizontalInside: BorderSide(
                          color: AppColor.shade1,
                        ),
                      ),
                  columnWidths: columnWidths,
                  defaultVerticalAlignment: widget.verticalAlignment,
                  children: [widget.rowBuilder(i)],
                ),
            ],
          )
        : Table(
            border: widget.bodyBorder ??
                TableBorder(
                  verticalInside: BorderSide(
                    color: AppColor.shade1,
                  ),
                  horizontalInside: BorderSide(
                    color: AppColor.shade1,
                  ),
                ),
            columnWidths: columnWidths,
            defaultVerticalAlignment: widget.verticalAlignment,
            children: <TableRow>[
              for (int i = 0; i < widget.numberOfRows; i++)
                widget.rowBuilder(i),
            ],
          );
  }

  List<TableRow> _buildColumns({
    required BuildContext context,
    List<String>? headers,
  }) {
    return [
      TableRow(
        children: [
          for (var title in headers!)
            LayoutBuilder(
              builder: (context, size) {
                if (widget.columnHeaderBuilder != null) {
                  var header = widget.columnHeaderBuilder!(context, title);
                  return header;
                }
                final textAlign = _centerHeaders.contains(title)
                    ? TextAlign.center
                    : _rightHeaders.contains(title)
                        ? TextAlign.right
                        : TextAlign.left;
                return SizedBox(
                  height: widget.headerHeight,
                  child: Row(
                    mainAxisAlignment: widget.headerButtonAlignment,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            title,
                            style: widget.headerStyle ??
                                Theme.of(context).textTheme.bodyText2,
                            textAlign: textAlign,
                          ),
                        ),
                      ),
                      if (widget.getHeaderButton != null &&
                          widget.getHeaderButton!(context, title) != null)
                        widget.getHeaderButton!(context, title)!,
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    ];
  }
}
