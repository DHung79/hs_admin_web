import 'package:flutter/material.dart';
import '/widgets/joytech_components/jt_indicator.dart';
import '../../core/admin/admin.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../layout_template/content_screen.dart';
import 'components/contact_content/contact_content.dart';
import 'components/profile_content/components/edit_profile.dart';
import 'components/profile_content/profile_content.dart';
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
              child: snapshot.hasData
                  ? _buildContent(snapshot.data!)
                  : const JTIndicator(),
            );
          }),
    );
  }

  Widget _buildContent(AdminModel account) {
    if (widget.tab == 1) {
      //profile
      return ProfileContent(
        route: settingRoute,
        account: account,
      );
    } else if (widget.tab == 2) {
      //contact
      return const ContactContent(
        route: settingRoute,
      );
    } else if (widget.tab == 3) {
      //edit profile
      return EditProfile(
        route: settingRoute,
        account: account,
      );
    } else if (widget.tab == 4) {
      //edit contact
      return const ContactContent(
        route: settingRoute,
        isEdit: true,
      );
    } else {
      return SettingContent(
        onFetch: _fetchDataOnPage,
        searchController: _searchController,
        route: settingRoute,
      );
    }
  }

  String _getSubTitle() {
    if (widget.tab == 1) {
      return 'Cài đặt / Hồ sơ của bạn';
    } else if (widget.tab == 2) {
      return 'Cài đặt / Thông tin liên lạc';
    } else if (widget.tab == 3) {
      return 'Cài đặt / Hồ sơ của bạn / Chỉnh sửa hồ sơ';
    } else if (widget.tab == 4) {
      return 'Cài đặt / Thông tin liên lạc / Chỉnh sửa thông tin liên lạc';
    } else {
      return 'Cài đặt';
    }
  }

  _fetchDataOnPage() {}
}
