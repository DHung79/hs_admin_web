import 'package:flutter/material.dart';
import '../../core/notification/push_noti.dart';
import '/core/admin/model/admin_model.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../layout_template/content_screen.dart';
import 'components/create_edit_push_noti.dart';
import 'components/edit_push_noti_content.dart';
import 'components/push_noti_list.dart';

class PushNotiManagementScreen extends StatefulWidget {
  final String id;
  final int tab;
  const PushNotiManagementScreen({
    Key? key,
    this.id = '',
    this.tab = 0,
  }) : super(key: key);

  @override
  State<PushNotiManagementScreen> createState() =>
      _PushNotiManagementScreenState();
}

class _PushNotiManagementScreenState extends State<PushNotiManagementScreen> {
  final _pageState = PageState();
  final _pushNotiBloc = PushNotiBloc();
  final _searchController = TextEditingController();

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _pushNotiBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      route: pushNotiManagementRoute,
      title: 'Quản lí thông báo đẩy',
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
    if (widget.id.isNotEmpty) {
      return EditPushNotiContent(
        route: pushNotiManagementRoute,
        id: widget.id,
        onFetch: _fetchDataOnPage,
      );
    } else if (widget.tab == 1) {
      return CreateEditPushNoti(
        route: pushNotiManagementRoute,
        onFetch: _fetchDataOnPage,
      );
    } else {
      return PushNotiList(
        pushNotiBloc: _pushNotiBloc,
        onFetch: _fetchDataOnPage,
        searchController: _searchController,
        route: pushNotiManagementRoute,
      );
    }
  }

  String _getSubTitle() {
    if (widget.tab == 1) {
      return 'Quản lí thông báo đẩy / Thêm thông báo đẩy';
    } else if (widget.id.isNotEmpty) {
      return 'Quản lí thông báo đẩy / Chỉnh sửa thông báo đẩy';
    } else {
      return 'Quản lí thông báo đẩy';
    }
  }

  _fetchDataOnPage(int page, {int? limit}) {
    pushNotiIndex = page;
    pushNotiSearchString = _searchController.text;
    Map<String, dynamic> params = {
      'limit': limit ?? 10,
      'page': pushNotiIndex,
      'search_string': pushNotiSearchString,
    };
    _pushNotiBloc.fetchAllData(params: params);
  }
}
