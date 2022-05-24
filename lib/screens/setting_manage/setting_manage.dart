import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/admin/model/admin_model.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import 'package:hs_admin_web/widgets/profile_item_widget.dart';
import '../../configs/svg_constants.dart';
import '../../configs/text_theme.dart';
import '../../configs/themes.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../layout_template/content_screen.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _pageState = PageState();
  late final TextEditingController _searchController = TextEditingController();
  late bool _checkSearch = true;

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      title: 'Cài đặt',
      name: 'Cài đặt',
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Cài đặt',
                        style:
                            WebTextTheme().mediumBigText(WebColor.textColor3),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: WebColor.textColor2,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color.fromRGBO(79, 117, 140, 0.16),
                              blurStyle: BlurStyle.outer,
                              blurRadius: 16,
                            )
                          ]),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  settingWidget(
                                    icon: SvgIcons.person,
                                    title: 'Hồ sơ của bạn',
                                    onTap: () {
                                      navigateTo(profileSettingRoute);
                                    },
                                  ),
                                  settingWidget(
                                    icon: SvgIcons.call,
                                    title: 'Thông tin liên lạc',
                                    onTap: () {
                                      navigateTo(contactInfoRoute);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: WebColor.shapeColor1,
                              height: 16,
                            ),
                            ProfileItemWidget(
                              sizeWidth: 144,
                              icon: SvgIcons.logout,
                              title: 'Đăng xuất',
                              onTap: () {},
                              color: WebColor.textColor7,
                            )
                          ]),
                    )
                  ],
                ));
          }),
    );
  }

  InkWell settingWidget({
    required SvgIconData icon,
    required String title,
    required void Function()? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SvgIcon(
                icon,
                color: WebColor.textColor3,
                size: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                title,
                style: WebTextTheme().normalText(WebColor.textColor3),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _fetchDataOnPage() {}
}
