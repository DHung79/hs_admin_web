import 'dart:math';

import 'package:flutter/material.dart';
import '../../../core/base/blocs/block_state.dart';
import '../../../core/service/service.dart';
import '../../../main.dart';
import '../../../core/base/models/common_model.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/joytech_components/joytech_components.dart';
import '../../../widgets/table/table.dart';

class ServiceList extends StatefulWidget {
  final String route;
  final ServiceBloc serviceBloc;
  final Function(int, {int? limit}) onFetch;
  final TextEditingController searchController;

  const ServiceList({
    Key? key,
    required this.route,
    required this.serviceBloc,
    required this.onFetch,
    required this.searchController,
  }) : super(key: key);

  @override
  State<ServiceList> createState() => _ServiceListState();
}

class _ServiceListState extends State<ServiceList> {
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
            'Danh sách dịch vụ',
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
        title: ScreenUtil.t(I18nKey.name)!,
        width: 250,
      ),
      TableHeader(
        title: 'Giá ',
        width: 200,
        isConstant: true,
      ),
      TableHeader(
        title: 'Cập nhật mới',
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
        width: 150,
        isConstant: true,
      ),
    ];
    return StreamBuilder(
      stream: widget.serviceBloc.allData,
      builder:
          (context, AsyncSnapshot<ApiResponse<ListServiceModel?>> snapshot) {
        if (snapshot.hasData) {
          final services = snapshot.data!.model!.records;
          final meta = snapshot.data!.model!.meta;
          _page = meta.page;
          _count = services.length;
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
                    numberOfRows: services.length,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                    blocState: widget.serviceBloc.allDataState,
                    hasBodyData: services.isNotEmpty,
                    isSearch: widget.searchController.text.isNotEmpty,
                    rowBuilder: (index) => _rowFor(
                      item: services[index],
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
          stream: widget.serviceBloc.allDataState,
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
        title: ScreenUtil.t(I18nKey.name)!,
        onPressed: () {},
      ),
      TableHeaderButton(
        title: 'Giá',
        onPressed: () {},
      ),
      TableHeaderButton(
        title: 'Cập nhật mới',
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
    required ServiceModel item,
    required Paging meta,
    required int index,
  }) {
    final recordOffset = meta.recordOffset;
    final action = item.isActive;
    final _editModel = EditServiceModel.fromModel(item);

    return TableRow(
      children: [
        tableCellText(
            title: '${recordOffset + index + 1}', alignment: Alignment.center),
        tableCellText(
          title: item.name,
        ),
        tableCellText(title: item.translations.last.name),
        tableCellText(
          title: item.translations.last.name,
        ),
        tableCellText(
          title: action ? 'Hoạt động' : 'Không hoạt động',
          style: AppTextTheme.mediumBodyText(
            action ? AppColor.shade9 : AppColor.others1,
          ),
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
                        SvgIcons.info,
                        color: AppColor.shadow,
                        size: 24,
                      ),
                    ),
                  ),
                  onTap: () {
                    navigateTo(serviceDetailRoute + '/' + item.id);
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
                        SvgIcons.editOutline,
                        color: AppColor.shadow,
                        size: 24,
                      ),
                    ),
                  ),
                  onTap: () {
                    navigateTo(editServiceRoute + '/' + item.id);
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
                        action ? SvgIcons.eyeOff : SvgIcons.removeRedEye,
                        color: AppColor.shadow,
                        size: 24,
                      ),
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _editModel.isActive = !action;
                      _changeServiceStatus(_editModel);
                    });
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

  _changeServiceStatus(EditServiceModel editModel) {
    widget.serviceBloc
        .editObject(editModel: editModel, id: editModel.id)
        .then((model) async {
      await Future.delayed(const Duration(milliseconds: 400));
      widget.onFetch(_count == 1 ? max(_page - 1, 1) : _page, limit: _limit);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ScreenUtil.t(I18nKey.updateSuccess)!)),
      );
    }).catchError((e, stacktrace) async {
      await Future.delayed(const Duration(milliseconds: 400));
      logDebug(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Có lỗi xảy khi trong quá trình cập nhật'),
        ),
      );
    });
  }
}
