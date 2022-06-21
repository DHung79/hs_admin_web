import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hs_admin_web/screens/push_noti_management_screen/components/push_noti_overview.dart';
import 'package:rxdart/rxdart.dart';
import '../../../core/base/blocs/block_state.dart';
import '../../../core/notification/push_noti.dart';
import '../../../main.dart';
import '../../../core/base/models/common_model.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/joytech_components/joytech_components.dart';
import '../../../widgets/table/table.dart';

class PushNotiList extends StatefulWidget {
  final String route;
  final PushNotiBloc pushNotiBloc;
  final Function(int, {int? limit}) onFetch;
  final TextEditingController searchController;

  const PushNotiList({
    Key? key,
    required this.route,
    required this.pushNotiBloc,
    required this.onFetch,
    required this.searchController,
  }) : super(key: key);

  @override
  State<PushNotiList> createState() => _PushNotiListState();
}

class _PushNotiListState extends State<PushNotiList> {
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
            'Danh sách thông báo đẩy',
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
        title: 'Tên',
        width: 250,
      ),
      TableHeader(
        title: 'Loại',
        width: 200,
        isConstant: true,
      ),
      TableHeader(
        title: 'Ngày tạo',
        width: 160,
        isConstant: true,
      ),
      TableHeader(
        title: 'Ngày chỉnh sửa',
        width: 200,
        isConstant: true,
      ),
      TableHeader(
        title: 'Hành động',
        width: 120,
        isConstant: true,
      ),
    ];
    // return StreamBuilder(
    //   stream: widget.notiBloc.allData,
    //   builder:
    //       (context, AsyncSnapshot<ApiResponse<ListPushNotiModel?>> snapshot) {
    // if (snapshot.hasData) {
    // final notifications = snapshot.data!.model!.records;
    final notifications = [
      PushNotiModel.fromJson({
        "name": 'Khuyến mãi tháng 2',
        "target_type": 'Khách hàng',
        "description": 'Lorem ipsum dolor sit amet, consectetur adipiscing ',
        "created_time": 02012022,
        "updated_time": 23042022,
      }),
      PushNotiModel.fromJson({
        "name": 'Khuyến mãi tháng 2',
        "target_type": 'Khách hàng',
        "description":
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ac eu odio etiam ac cras nisi imperdiet quam. At accumsan, ut nibh diam nullam. Varius felis tincidunt purus ullamcorper praesent elementum duis. Velit arcu hac quis sit sed urna orci tincidunt suspendisse. Nunc lacus dignissim interdum eget ipsum dum eget ipsum...',
        "created_time": 02012022,
        "updated_time": 23042022,
      }),
    ];
    // final meta = snapshot.data!.model!.meta;
    // _page = meta.page;
    // _count = notifications.length;
    final meta = Paging.fromJson(
      {
        "total_records": notifications.length,
        "limit": _limit,
        "page": _page,
        "total_page": 1,
      },
    );
    final dataState = BehaviorSubject<BlocState>();
    dataState.sink.add(BlocState.completed);
    final blocState = dataState.stream;
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
              headerStyle: AppTextTheme.mediumHeaderTitle(AppColor.shadow),
              numberOfRows: notifications.length,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
              // blocState: widget.pushNotiBloc.allDataState,
              blocState: blocState,
              hasBodyData: notifications.isNotEmpty,
              isSearch: widget.searchController.text.isNotEmpty,
              rowBuilder: (index) => _rowFor(
                item: notifications[index],
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
    // }
    // return StreamBuilder(
    //   stream: widget.notiBloc.allDataState,
    //   builder: (context, state) {
    //     if (!state.hasData || state.data == BlocState.fetching) {
    //       return const JTIndicator();
    //     } else {
    //       return const SizedBox();
    //     }
    //   },
    // );
    //   },
    // );
  }

  Widget? _getHeaderButton(
    BuildContext tableContext,
    String title,
  ) {
    final List<TableHeaderButton> _tableHeadersButton = [
      TableHeaderButton(
        title: 'Loại',
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
    required PushNotiModel item,
    required Paging meta,
    required int index,
  }) {
    final recordOffset = meta.recordOffset;

    return TableRow(
      children: [
        tableCellText(
            title: '${recordOffset + index + 1}', alignment: Alignment.center),
        tableCellOnHover(
          child: Container(
            constraints: const BoxConstraints(minHeight: 40),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  item.name,
                  style: AppTextTheme.normalText(AppColor.black),
                ),
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return PushNotiOverView();
                  },
                );
              },
            ),
          ),
          onHoverChild: Material(
            color: Colors.transparent,
            child: Container(
              constraints: const BoxConstraints(
                maxHeight: 210,
                maxWidth: 425,
              ),
              decoration: BoxDecoration(
                color: AppColor.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: [
                  BoxShadow(
                    color: AppColor.shadow.withOpacity(0.16),
                    blurRadius: 16,
                    blurStyle: BlurStyle.outer,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: AppTextTheme.mediumHeaderTitle(AppColor.black),
                    ),
                    Text(
                      item.description,
                      style: AppTextTheme.normalText(AppColor.text3),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Xem chi tiết',
                          style: AppTextTheme.normalText(AppColor.primary2),
                        ),
                      ),
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return PushNotiOverView();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        tableCellText(
          title: item.targetType,
        ),
        tableCellText(
          title: item.createdTime.toString(),
        ),
        tableCellText(
          title: item.updatedTime.toString(),
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
                    navigateTo(userInfoRoute + '/' + item.id);
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
                        SvgIcons.edit,
                        color: AppColor.shadow,
                        size: 24,
                      ),
                    ),
                  ),
                  onTap: () {
                    navigateTo(editUserRoute + '/' + item.id);
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
                        SvgIcons.delete,
                        color: AppColor.shadow,
                        size: 24,
                      ),
                    ),
                  ),
                  onTap: () {
                    // _confirmDelete(id: item.id);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
    required PushNotiModel task,
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
                _deleteObjectById(id: task.id);
              }
              if (event.logicalKey == LogicalKeyboardKey.escape) {
                Navigator.of(context).pop();
              }
            });
          },
          child: JTConfirmDialog(
            headerTitle: 'Cảnh báo',
            contentText:
                'Bạn có chắc muốn hủy dịch vụ Dọn dẹp nhà theo giờ của ?',
            onCanceled: () {
              Navigator.of(context).pop();
            },
            onComfirmed: () {
              Navigator.of(context).pop();
              _deleteObjectById(id: task.id);
            },
          ),
        );
      },
    );
  }

  _deleteObjectById({
    required String id,
  }) {
    widget.pushNotiBloc.deleteObject(id: id).then((model) async {
      await Future.delayed(const Duration(milliseconds: 400));
      widget.onFetch(_count == 1 ? max(_page - 1, 1) : _page, limit: _limit);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ScreenUtil.t(I18nKey.deleted)!)),
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

Widget getStatusText(status) {
  switch (status) {
    case 0:
      return Text(
        'Đang chờ',
        style: AppTextTheme.mediumBodyText(AppColor.text8),
      );
    case 1:
      return Text(
        'Đã nhận',
        style: AppTextTheme.mediumBodyText(AppColor.text3),
      );
    case 2:
      return Text(
        'Đang tiến hành',
        style: AppTextTheme.mediumBodyText(AppColor.primary2),
      );
    case 3:
      return Text(
        'Thành công',
        style: AppTextTheme.mediumBodyText(AppColor.shade9),
      );
    case 4:
      return Text(
        'Đã hủy',
        style: AppTextTheme.mediumBodyText(AppColor.others1),
      );
    default:
      return Text(
        '',
        style: AppTextTheme.mediumBodyText(AppColor.black),
      );
  }
}
