import 'package:flutter/material.dart';
import '../../core/admin/admin.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../layout_template/content_screen.dart';
import 'components/profile_content.dart';
import 'components/setting_content.dart';

class SettingScreen extends StatefulWidget {
  final int tab;
  const SettingScreen({
    Key? key,
    this.tab = 0,
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _pageState = PageState();
  final _adminBloc = AdminBloc();
  final _searchController = TextEditingController();

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _adminBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      route: settingRoute,
      title: 'Cài đặt',
      subTitle: _getSubTitle(),
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage();
      },
      appBarHeight: 0,
      child: FutureBuilder(
          future: _pageState.currentUser,
          builder: (context, AsyncSnapshot<AdminModel> snapshot) {
            return PageContent(
              userSnapshot: snapshot,
              pageState: _pageState,
              onFetch: () {
                _fetchDataOnPage();
              },
              child: _buildContent(),
            );
          }),
    );
  }

  Widget _buildContent() {
    if (widget.tab == 1) {
      return ProfileContent(
        route: tasksRoute,
        onFetch: _fetchDataOnPage,
      );
    } else {
      return SettingContent(
        onFetch: _fetchDataOnPage,
        searchController: _searchController,
        route: tasksRoute,
      );
    }
  }

  String _getSubTitle() {
    if (widget.tab == 1) {
      return 'Cài đặt / Hồ sơ của bạn';
    } else {
      return 'Cài đặt';
    }
  }

  _fetchDataOnPage() {}
}
