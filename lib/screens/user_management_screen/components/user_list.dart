import 'package:flutter/material.dart';
import 'package:hs_admin_web/widgets/jt_indicator.dart';
import '../../../core/base/blocs/block_state.dart';
import '../../../main.dart';
import '../../../core/base/models/common_model.dart';
import '../../../core/user/user.dart';
import '../../../routes/route_names.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/table/table.dart';

class UserList extends StatefulWidget {
  final UserBloc userBloc;
  final Function(int, {int? limit}) onFetch;
  final TextEditingController searchController;
  final String route;
  const UserList({
    Key? key,
    required this.userBloc,
    required this.onFetch,
    required this.searchController,
    required this.route,
  }) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  int _page = 0;
  int _limit = 10;
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            'DANH SÁCH NGƯỜI DÙNG',
            style: AppTextTheme.mediumBigText(AppColor.text3),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _searchBar(),
              AppButtonTheme.fillRounded(
                constraints: const BoxConstraints(minHeight: 44),
                color: AppColor.primary2,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Thêm người dùng',
                          style: AppTextTheme.mediumBodyText(Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  navigateTo(addUserRoute);
                },
              ),
            ],
          ),
        ),
        _buildTable(),
      ],
    );
  }

  SizedBox _searchBar() {
    final isSearching = widget.searchController.text.isNotEmpty;
    return SizedBox(
      width: 265,
      height: 44,
      child: TextFormField(
        controller: widget.searchController,
        cursorHeight: 20,
        cursorColor: AppColor.text7,
        style: AppTextTheme.normalText(AppColor.text1),
        decoration: InputDecoration(
          hoverColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Tìm kiếm',
          hintStyle: AppTextTheme.normalText(AppColor.text7),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.search,
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
                      });
                    },
                  ),
                )
              : null,
        ),
        onChanged: (String value) {
          setState(() {});
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
        title: ScreenUtil.t(I18nKey.name)!,
        width: 250,
        isConstant: true,
      ),
      TableHeader(
        title: 'Email',
        width: 250,
      ),
      TableHeader(
        title: ScreenUtil.t(I18nKey.phoneNumber)!,
        width: 160,
        isConstant: true,
      ),
      TableHeader(
        title: ScreenUtil.t(I18nKey.address)!,
        width: 250,
      ),
      TableHeader(
        title: 'Hành động',
        width: 150,
        isConstant: true,
      ),
    ];
    return Stack(
      children: [
        StreamBuilder(
          stream: widget.userBloc.allData,
          builder:
              (context, AsyncSnapshot<ApiResponse<ListUserModel?>> snapshot) {
            if (snapshot.hasData) {
              final users = snapshot.data!.model!.records;
              final meta = snapshot.data!.model!.meta;
              _page = meta.page;
              _count = users.length;
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
                        numberOfRows: users.length,
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 16),
                        rowBuilder: (index) => _rowFor(
                          item: users[index],
                          index: index,
                          meta: meta,
                        ),
                        hasBodyData: users.isNotEmpty,
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
            return const SizedBox();
          },
        ),
        StreamBuilder(
          stream: widget.userBloc.allDataState,
          builder: (context, state) {
            if (!state.hasData || state.data == BlocState.fetching) {
              return const JTIndicator();
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  Widget? _getHeaderButton(
    BuildContext tableContext,
    String title,
  ) {
    final List<TableHeaderButton> _tableHeadersButton = [
      TableHeaderButton(
        title: ScreenUtil.t(I18nKey.name)!,
        onPressed: () {},
      ),
      TableHeaderButton(
        title: 'Email',
        onPressed: () {},
      ),
      TableHeaderButton(
        title: ScreenUtil.t(I18nKey.phoneNumber)!,
        onPressed: () {},
      ),
      TableHeaderButton(
        title: ScreenUtil.t(I18nKey.address)!,
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
    required UserModel item,
    required Paging meta,
    required int index,
  }) {
    final recordOffset = meta.recordOffset;

    return TableRow(
      children: [
        tableCellText(
            title: '${recordOffset + index + 1}', alignment: Alignment.center),
        tableCellText(
          title: item.name,
        ),
        tableCellText(title: item.email),
        tableCellText(
          title: item.phoneNumber,
        ),
        tableCellText(
          title: item.address,
        ),
        tableCellText(
          title: item.address,
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
          child: InkWell(
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Text(
                      '10',
                      style: AppTextTheme.normalText(AppColor.text1),
                    ),
                  ),
                  SvgIcon(
                    SvgIcons.keyboardDown,
                    color: AppColor.text7,
                    size: 24,
                  )
                ],
              ),
            ),
            onTap: () {},
          ),
        ),
        SizedBox(
          height: 44,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
              ),
              child: Row(
                children: [
                  SvgIcon(
                    SvgIcons.calendar,
                    color: AppColor.text8,
                    size: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Chỉnh sửa bảng',
                      style: AppTextTheme.mediumBodyText(
                        AppColor.text8,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  TextButton backgroundButton({
    required String text,
    required SvgIconData icon,
    required Color color,
    required onPressed,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 16,
        ),
        child: Row(
          children: [
            SvgIcon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              text,
              style: AppTextTheme.mediumBodyText(Colors.white),
            )
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }
}
