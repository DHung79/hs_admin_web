import 'package:flutter/material.dart';
import '/core/admin/model/admin_model.dart';
import '/routes/route_names.dart';
import '../../core/authentication/auth.dart';
import '../../core/user/user.dart';
import '../../main.dart';
import '../layout_template/content_screen.dart';
import 'components/user_info.dart';
import 'components/user_list.dart';

class UserManageScreen extends StatefulWidget {
  final int tab;
  final String id;
  const UserManageScreen({
    Key? key,
    this.tab = 0,
    this.id = '',
  }) : super(key: key);

  @override
  State<UserManageScreen> createState() => _UserManageScreenState();
}

class _UserManageScreenState extends State<UserManageScreen> {
  final _pageState = PageState();
  final _userBloc = UserBloc();
  final _userInfoBloc = UserBloc();

  final _searchController = TextEditingController();

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    _userInfoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      title: 'Quản lí người dùng',
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
                child: _buildContent());
          }),
    );
  }

  Widget _buildContent() {
    if (widget.tab == 2) {
      return UserInfo(
        userInfoBloc: _userInfoBloc,
        route: userManagementRoute,
        userId: widget.id,
      );
    } else {
      return UserList(
        userBloc: _userBloc,
        onFetch: _fetchDataOnPage,
        searchController: _searchController,
        route: userManagementRoute,
      );
    }
  }

  String _getSubTitle() {
    if (widget.tab == 1) {
      return 'Quản lí người dùng / Xem thông tin người dùng';
    } else {
      return 'Quản lí người dùng';
    }
  }

  _fetchDataOnPage(int page, {int? limit}) {
    userManagementIndex = page;
    userManagementSearchString = _searchController.text;
    Map<String, dynamic> params = {
      'limit': limit ?? 10,
      'page': userManagementIndex,
      'search_string': userManagementSearchString,
    };
    _userBloc.fetchAllData(params: params);
  }
}
