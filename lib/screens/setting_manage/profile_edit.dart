import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/admin/model/admin_model.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import 'package:hs_admin_web/widgets/home_widget/back_button_widget.dart';
import 'package:hs_admin_web/widgets/home_widget/background_button_widget.dart';
import 'package:hs_admin_web/widgets/home_widget/dropdown_widget.dart';
import 'package:hs_admin_web/widgets/input_widget.dart';
import '../../configs/svg_constants.dart';
import '../../configs/text_theme.dart';
import '../../configs/themes.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../widgets/home_widget/form_user_widget.dart';
import '../layout_template/content_screen.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _pageState = PageState();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController namePriceController =
      TextEditingController();

  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  late final TextEditingController numberPhoneController =
      TextEditingController();
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
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage();
      },
      name: 'Cài đặt',
      title: 'Cài đặt / Hồ sơ của bạn / Chỉnh sửa hồ sơ',
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
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Chỉnh sửa hồ sơ',
                            style: WebTextTheme()
                                .mediumBigText(WebColor.textColor3),
                          ),
                        ),
                        Row(
                          children: [
                            removeButton(),
                            const SizedBox(
                              width: 10,
                            ),
                            BackgroundButton(
                              icon: SvgIcons.check,
                              color: WebColor.testColor7,
                              text: 'Đồng ý',
                              onPressed: () {},
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 16,
                            color: Color.fromRGBO(79, 117, 140, 0.24),
                            blurStyle: BlurStyle.outer,
                          ),
                        ]),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        imageUser(),
                        const SizedBox(
                          width: 10,
                        ),
                        profileUser(),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
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
              color: WebColor.textColor3,
              size: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Hủy bỏ',
              style: WebTextTheme().mediumBodyText(WebColor.textColor3),
            )
          ],
        ),
      ),
      onPressed: () {},
    );
  }

  Flexible profileUser() {
    return Flexible(
      flex: 9,
      child: Form(
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: FormUserWidget(
                    showTitle: true,
                    isWidth: false,
                    controller: nameController,
                    hintText: 'Nhập tên dịch vụ',
                    title: 'Tên',
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: FormUserWidget(
                    showTitle: true,
                    isWidth: false,
                    controller: nameController,
                    hintText: 'Nhập email',
                    title: 'Email',
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: FormUserWidget(
                    showTitle: true,
                    isWidth: false,
                    controller: nameController,
                    hintText: 'Nhập địa chỉ',
                    title: 'Địa chỉ',
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: FormUserWidget(
                    showTitle: true,
                    isWidth: false,
                    controller: nameController,
                    hintText: 'Nhập số điện thoại',
                    title: 'Số điện thoại',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Row priceAndAdd() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Giá',
          style: WebTextTheme().mediumBodyText(WebColor.shadowColor),
        ),
        TextButton(
          child: Row(
            children: [
              SvgIcon(
                SvgIcons.close,
                color: WebColor.primaryColor2,
                size: 24,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Thêm',
                style: WebTextTheme().mediumBodyText(
                  WebColor.primaryColor2,
                ),
              ),
            ],
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  Flexible imageUser() {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              width: 100,
              height: 100,
              child: CircleAvatar(
                backgroundImage: NetworkImage(''),
                backgroundColor: WebColor.textColor7,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Thay đổi hình ảnh',
                  style: WebTextTheme().mediumBodyText(
                    WebColor.primaryColor2,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _fetchDataOnPage() {}
}
