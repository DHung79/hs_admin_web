import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/base/blocs/block_state.dart';
import '../../../core/task/task.dart';
import '../../../main.dart';
import '../../../core/base/models/common_model.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/joytech_components/joytech_components.dart';
import '../../../widgets/table/table.dart';

class TaskList extends StatefulWidget {
  final String route;
  final TaskBloc taskBloc;
  final Function(int, {int? limit}) onFetch;
  final TextEditingController searchController;

  const TaskList({
    Key? key,
    required this.route,
    required this.taskBloc,
    required this.onFetch,
    required this.searchController,
  }) : super(key: key);

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  int _page = 0;
  int _limit = 10;
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildTable(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'Danh sách đặt hàng',
            style: AppTextTheme.mediumBigText(AppColor.text3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _searchBar(),
            ],
          ),
        ),
      ],
    );
  }

  SizedBox _searchBar() {
    bool isSearching = widget.searchController.text.isNotEmpty;
    return SizedBox(
      width: 265,
      height: 44,
      child: JTSearchField(
        controller: widget.searchController,
        cursorHeight: 20,
        cursorColor: AppColor.text7,
        style: AppTextTheme.normalText(AppColor.text1),
        hoverColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        fillColor: Colors.white,
        hintText: 'Tìm kiếm',
        hintStyle: AppTextTheme.normalText(AppColor.text7),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(10),
          child: SvgIcon(
            SvgIcons.search,
            color: isSearching ? AppColor.primary2 : AppColor.text7,
            size: 24,
          ),
        ),
        suffixIcon: isSearching
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  child: Icon(
                    Icons.close,
                    color: AppColor.others1,
                    size: 24,
                  ),
                  onTap: () {
                    setState(() {
                      widget.searchController.text = '';
                      widget.onFetch(1);
                    });
                  },
                ),
              )
            : null,
        onChanged: (newValue) {
          setState(() {
            widget.searchController.text = newValue;
            widget.searchController.selection =
                TextSelection.collapsed(offset: newValue.length);
          });
        },
        onFetch: () {
          widget.onFetch(1);
        },
      ),
    );
  }

  Widget _buildTable() {
    final List<TableHeader> tableHeaders = [
      TableHeader(
        title: ScreenUtil.t(I18nKey.no)!.toUpperCase(),
        width: 65,
        isConstant: true,
      ),
      TableHeader(
        title: 'Dịch vụ',
        width: 250,
      ),
      TableHeader(
        title: 'Tổng tiền ',
        width: 200,
        isConstant: true,
      ),
      TableHeader(
        title: 'Khách hàng',
        width: 160,
        isConstant: true,
      ),
      TableHeader(
        title: 'Trạng thái',
        width: 200,
        isConstant: true,
      ),
      TableHeader(
        title: 'Hành động',
        width: 120,
        isConstant: true,
      ),
    ];
    return StreamBuilder(
      stream: widget.taskBloc.allData,
      builder: (context, AsyncSnapshot<ApiResponse<ListTaskModel?>> snapshot) {
        if (snapshot.hasData) {
          final tasks = snapshot.data!.model!.records;
          final meta = snapshot.data!.model!.meta;
          _page = meta.page;
          _count = tasks.length;
          return Column(
            children: [
              LayoutBuilder(
                builder: (context, size) {
                  return DynamicTable(
                    columnWidthRatio: tableHeaders,
                    getHeaderButton: _getHeaderButton,
                    headerColor: AppColor.white,
                    headerBorder: TableBorder(
                      bottom: BorderSide(color: AppColor.white),
                    ),
                    headerStyle:
                        AppTextTheme.mediumHeaderTitle(AppColor.shadow),
                    numberOfRows: tasks.length,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    blocState: widget.taskBloc.allDataState,
                    hasBodyData: tasks.isNotEmpty,
                    isSearch: widget.searchController.text.isNotEmpty,
                    rowBuilder: (index) => _rowFor(
                      item: tasks[index],
                      index: index,
                      meta: meta,
                    ),
                    bodyBorder: TableBorder(
                      horizontalInside: BorderSide(
                        color: AppColor.transparent,
                      ),
                    ),
                  );
                },
              ),
              TablePagination(
                onFetch: (page) {
                  widget.onFetch(page, limit: _limit);
                },
                pagination: meta,
                leading: tableLimit(),
              ),
            ],
          );
        }
        return StreamBuilder(
          stream: widget.taskBloc.allDataState,
          builder: (context, state) {
            if (!state.hasData || state.data == BlocState.fetching) {
              return const JTIndicator();
            } else {
              return const SizedBox();
            }
          },
        );
      },
    );
  }

  Widget? _getHeaderButton(
    BuildContext tableContext,
    String title,
  ) {
    final List<TableHeaderButton> _tableHeadersButton = [
      TableHeaderButton(
        title: 'Dịch vụ',
        onPressed: () {},
      ),
      TableHeaderButton(
        title: 'Tổng tiền',
        onPressed: () {},
      ),
      TableHeaderButton(
        title: 'Khách hàng',
        onPressed: () {},
      ),
      TableHeaderButton(
        title: 'Trạng thái',
        onPressed: () {},
      ),
    ];
    if (_tableHeadersButton.where((e) => e.title == title).isNotEmpty) {
      final headerButton =
          _tableHeadersButton.where((e) => e.title == title).first;
      return InkWell(
        child: SvgIcon(
          SvgIcons.filter,
          color: AppColor.text7,
          size: 18,
        ),
        onTap: headerButton.onPressed,
      );
    } else {
      return null;
    }
  }

  TableRow _rowFor({
    required TaskModel item,
    required Paging meta,
    required int index,
  }) {
    final recordOffset = meta.recordOffset;

    return TableRow(
      children: [
        tableCellText(
            title: '${recordOffset + index + 1}', alignment: Alignment.center),
        tableCellText(
          title: item.service!.translations.last.name,
        ),
        tableCellText(title: item.totalPrice.toString() + ' VND'),
        tableCellText(
          title: item.user?.name,
        ),
        tableCellText(
          title: _getStatusText(item.status),
          style: _getStatusStyle(item.status),
        ),
        tableCellText(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: const EdgeInsets.all(4),
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: SizedBox(
                      child: SvgIcon(
                        SvgIcons.info1,
                        color: AppColor.shadow,
                        size: 24,
                      ),
                    ),
                  ),
                  onTap: () {
                    navigateTo(taskDetailRoute + '/' + item.id!);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: SizedBox(
                      child: SvgIcon(
                        SvgIcons.close,
                        color: AppColor.shadow,
                        size: 24,
                      ),
                    ),
                  ),
                  onTap: () {
                    _confirmDelete(id: item.id!);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _getStatusText(status) {
    switch (status) {
      case 0:
        return 'Đang chờ';
      case 1:
        return 'Đã nhận';
      case 2:
        return 'Đang tiến hành';
      case 3:
        return 'Thành công';
      case 4:
        return 'Đã hủy';
      default:
        return '';
    }
  }

  TextStyle _getStatusStyle(status) {
    switch (status) {
      case 0:
        return AppTextTheme.mediumBodyText(AppColor.text8);
      case 1:
        return AppTextTheme.mediumBodyText(AppColor.text3);
      case 2:
        return AppTextTheme.mediumBodyText(AppColor.primary2);
      case 3:
        return AppTextTheme.mediumBodyText(AppColor.shade9);
      case 4:
        return AppTextTheme.mediumBodyText(AppColor.others1);
      default:
        return AppTextTheme.mediumBodyText(AppColor.black);
    }
  }

  Widget tableLimit() {
    return Row(
      children: [
        Text(
          'Number on page',
          style: AppTextTheme.normalText(
            AppColor.text3,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: JTDropdownButtonFormField<int>(
            defaultValue: _limit,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            dataSource: const [
              {'name': '10', 'value': 10},
              {'name': '15', 'value': 15},
              {'name': '20', 'value': 20},
            ],
            onChanged: (newValue) {
              setState(() {
                _limit = newValue!;
                widget.onFetch(1, limit: _limit);
              });
            },
          ),
        ),
      ],
    );
  }

  _confirmDelete({
    required String id,
  }) {
    final _focusNode = FocusNode();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        FocusScope.of(context).requestFocus(_focusNode);
        return RawKeyboardListener(
          focusNode: _focusNode,
          onKey: (RawKeyEvent event) {
            setState(() {
              if (event.logicalKey == LogicalKeyboardKey.enter) {
                Navigator.of(context).pop();
                _deleteObjectById(id: id);
              }
              if (event.logicalKey == LogicalKeyboardKey.escape) {
                Navigator.of(context).pop();
              }
            });
          },
          child: JTConfirmDialog(
            headerTitle: 'Cảnh báo',
            contentText:
                'Bạn có chắc muốn hủy đặt hàng Dọn dẹp nhà theo giờ của ?',
            onCanceled: () {
              Navigator.of(context).pop();
            },
            onComfirmed: () {
              Navigator.of(context).pop();
              _deleteObjectById(id: id);
            },
          ),
        );
      },
    );
  }

  _deleteObjectById({
    required String id,
  }) {
    widget.taskBloc.deleteObject(id: id).then((model) async {
      await Future.delayed(const Duration(milliseconds: 400));
      widget.onFetch(_count == 1 ? max(_page - 1, 1) : _page, limit: _limit);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(ScreenUtil.t(I18nKey.deleted)! +
                ' đặt hàng của ${model.user?.name}.')),
      );
    }).catchError((e, stacktrace) async {
      await Future.delayed(const Duration(milliseconds: 400));
      logDebug(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ScreenUtil.t(I18nKey.errorWhileDelete)!),
        ),
      );
    });
  }
}
