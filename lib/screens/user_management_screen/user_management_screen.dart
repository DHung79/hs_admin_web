import 'package:flutter/material.dart';
import '/core/admin/model/admin_model.dart';
import '/routes/route_names.dart';
import '../../core/authentication/auth.dart';
import '../../core/user/user.dart';
import '../../main.dart';
import '../layout_template/content_screen.dart';
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
  late final TextEditingController _searchController = TextEditingController();
  late bool _checkSearch = true;
  final _userBloc = UserBloc();
  final _userSearchController = TextEditingController();

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      name: 'Quản lí người dùng',
      title: 'Quản lí người dùng',
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
              child: UserList(
                userBloc: _userBloc,
                onFetch: _fetchDataOnPage,
                searchController: _userSearchController,
                route: userManagementRoute,
              ),
            );
          }),
    );
  }

  _fetchDataOnPage(int page, {int? limit}) {
    userManagementIndex = page;
    userManagementSearchString = _userSearchController.text;
    Map<String, dynamic> params = {
      'limit': limit ?? 10,
      'page': userManagementIndex,
      'search_string': userManagementSearchString,
    };
    _userBloc.fetchAllData(params: params);
  }
}
