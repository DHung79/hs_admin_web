import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/admin/model/admin_model.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/app_theme.dart';
import '../../widgets/back_button_widget.dart';
import '../../widgets/profile_item_widget.dart';
import '../layout_template/content_screen.dart';

class ProfileSetting extends StatefulWidget {
  const ProfileSetting({Key? key}) : super(key: key);

  @override
  State<ProfileSetting> createState() => _ProfileSettingState();
}

class _ProfileSettingState extends State<ProfileSetting> {
  final _pageState = PageState();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  late final TextEditingController numberPhoneController =
      TextEditingController();
  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage();
      },
      name: 'Cài đặt',
      title: 'Cài đặt / Hồ sơ của bạn',
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
                  BackButtonWidget(
                    onPressed: () {
                      navigateTo(settingManageRoute);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        addUser(),
                        eventProfile(),
                      ],
                    ),
                  ),
                  formprofile(context),
                ],
              ),
            );
          }),
    );
  }

  Row eventProfile() {
    return Row(
      children: [
        TextButton(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
            child: Row(
              children: [
                SvgIcon(
                  SvgIcons.expandMore,
                  color: AppColor.text8,
                  size: 24,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Đổi mật khẩu',
                  style: AppTextTheme.mediumBodyText(AppColor.text8),
                )
              ],
            ),
          ),
          onPressed: () {},
        ),
        const SizedBox(
          width: 10,
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            side: BorderSide(
              color: AppColor.primary2,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                SvgIcon(
                  SvgIcons.edit,
                  color: AppColor.primary2,
                  size: 24,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Chỉnh sửa',
                  style: AppTextTheme.mediumBodyText(AppColor.primary2),
                ),
              ],
            ),
          ),
          onPressed: () {
            navigateTo(editProfileRoute);
          },
        ),
      ],
    );
  }

  Padding addUser() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'Hồ sơ của bạn',
        style: AppTextTheme.mediumBigText(AppColor.text3),
      ),
    );
  }

  Container formprofile(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            blurRadius: 16,
            color: Color.fromRGBO(79, 117, 140, 0.24),
            blurStyle: BlurStyle.outer,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imageUser(),
              Container(
                width: 1,
                height: MediaQuery.of(context).size.height / 4,
                color: AppColor.shade1,
                margin: const EdgeInsets.symmetric(horizontal: 16),
              ),
              profileUser(),
            ],
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
        ],
      ),
    );
  }

  TextButton removeButton() {
    return TextButton(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 16,
        ),
        child: Row(
          children: [
            SvgIcon(
              SvgIcons.close,
              color: AppColor.text3,
              size: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Hủy bỏ',
              style: AppTextTheme.mediumBodyText(AppColor.text3),
            )
          ],
        ),
      ),
      onPressed: () {},
    );
  }

  Widget profileUser() {
    return Expanded(
      flex: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: lineContent(
          title: 'Thông tin liên lạc',
          line1a: 'Số điện thoại: ',
          line1b: '0385140807',
          line2a: 'Địa chỉ: ',
          line2b: '358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa',
          line3a: 'Email: ',
          line3b: 'nguyenduchoangphi922016@gmail.com',
        ),
      ),
    );
  }

  Column lineContent({
    bool? even = false,
    required String title,
    required String line1a,
    required String line1b,
    required String line2a,
    required String line2b,
    required String line3a,
    required String line3b,
    String? line4a,
    String? line4b,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextTheme.normalHeaderTitle(AppColor.shadow),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  lineProfile(
                    name: line1a,
                    description: line1b,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  lineProfile(
                    name: line2a,
                    description: line2b,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 32,
            ),
            Flexible(
              flex: 1,
              child: Column(
                children: [
                  lineProfile(
                    name: line3a,
                    description: line3b,
                  ),
                  if (even!)
                    const SizedBox(
                      height: 16,
                    ),
                  if (even)
                    lineProfile(
                      name: line4a!,
                      description: line4b!,
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row lineProfile({required String name, required String description}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: AppTextTheme.normalText(AppColor.text8),
        ),
        Flexible(
          child: Text(
            description,
            style: AppTextTheme.normalText(AppColor.text3),
            maxLines: 5,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Flexible imageUser() {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundImage: const NetworkImage(''),
                backgroundColor: AppColor.text7,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Nancy Jewel McDonie',
              style: AppTextTheme.mediumBodyText(AppColor.text3),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchDataOnPage() {}
}
