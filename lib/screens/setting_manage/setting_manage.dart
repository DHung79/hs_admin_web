import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/admin/model/admin_model.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import 'package:hs_admin_web/widgets/profile_item_widget.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/app_theme.dart';
import '../layout_template/content_screen.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _pageState = PageState();

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
                        style: AppTextTheme.mediumBigText(AppColor.text3),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                          color: AppColor.text2,
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
                                    icon: SvgIcons.user,
                                    title: 'Hồ sơ của bạn',
                                    onTap: () {
                                      navigateTo(profileSettingRoute);
                                    },
                                  ),
                                  settingWidget(
                                    icon: SvgIcons.telephone,
                                    title: 'Thông tin liên lạc',
                                    onTap: () {
                                      navigateTo(contactInfoRoute);
                                    },
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColor.shade1,
                              height: 16,
                            ),
                            ProfileItemWidget(
                              sizeWidth: 144,
                              icon: SvgIcons.logout,
                              title: 'Đăng xuất',
                              onTap: () {},
                              color: AppColor.text7,
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
                color: AppColor.text3,
                size: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                title,
                style: AppTextTheme.normalText(AppColor.text3),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _fetchDataOnPage() {}
}
