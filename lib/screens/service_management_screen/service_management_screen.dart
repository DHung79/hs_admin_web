import 'package:flutter/material.dart';
import '../../core/service/service.dart';
import '/core/admin/model/admin_model.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../layout_template/content_screen.dart';
import 'components/create_edit_service_form.dart';
import 'components/edit_service_content.dart';
import 'components/service_detail_content.dart';
import 'components/service_list.dart';

class ServiceManagementScreen extends StatefulWidget {
  final int tab;
  final String id;
  const ServiceManagementScreen({
    Key? key,
    this.tab = 0,
    this.id = '',
  }) : super(key: key);

  @override
  State<ServiceManagementScreen> createState() => _ServiceManagementScreenState();
}

class _ServiceManagementScreenState extends State<ServiceManagementScreen> {
  final _pageState = PageState();
  final _serviceBloc = ServiceBloc();
  final _searchController = TextEditingController();

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _serviceBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      route: serviceManagementRoute,
      title: 'Quản lí dịch vụ',
      subTitle: _getSubTitle(),
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage(1);
      },
      appBarHeight: 0,
      child: FutureBuilder(
          future: _pageState.currentUser,
          builder: (context, AsyncSnapshot<AdminModel> snapshot) {
            return PageContent(
              userSnapshot: snapshot,
              pageState: _pageState,
              onFetch: () {
                _fetchDataOnPage(1);
              },
              child: _buildContent(),
            );
          }),
    );
  }

  Widget _buildContent() {
    if (widget.tab == 1) {
      return CreateEditServiceForm(
        serviceBloc: _serviceBloc,
        route: serviceManagementRoute,
        onFetch: _fetchDataOnPage,
      );
    } else if (widget.tab == 2) {
      return ServiceDetailContent(
        route: serviceManagementRoute,
        id: widget.id,
        onFetch: _fetchDataOnPage,
      );
    } else if (widget.tab == 3) {
      return EditServiceContent(
        route: serviceManagementRoute,
        id: widget.id,
        onFetch: _fetchDataOnPage,
      );
    } else {
      return ServiceList(
        serviceBloc: _serviceBloc,
        onFetch: _fetchDataOnPage,
        searchController: _searchController,
        route: serviceManagementRoute,
      );
    }
  }

  String _getSubTitle() {
    if (widget.tab == 1) {
      return 'Quản lí dịch vụ / Chỉnh sửa thông tin dịch vụ';
    } else if (widget.tab == 2) {
      return 'Quản lí dịch vụ / Xem thông tin dịch vụ ';
    } else {
      return 'Quản lí dịch vụ';
    }
  }

  _fetchDataOnPage(int page, {int? limit}) {
    serviceManagementIndex = page;
    serviceManagementSearchString = _searchController.text;
    Map<String, dynamic> params = {
      'limit': limit ?? 10,
      'page': serviceManagementIndex,
      'search_string': serviceManagementSearchString,
    };
    _serviceBloc.fetchAllData(params: params);
  }
}
