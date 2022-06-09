import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/admin/model/admin_model.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/app_theme.dart';
import '../../widgets/go_back_button.dart';
import '../../widgets/form_user_widget.dart';
import '../../widgets/line_content.dart';
import '../../widgets/profile_item_widget.dart';
import '../layout_template/content_screen.dart';

class ContactInfo extends StatefulWidget {
  const ContactInfo({Key? key}) : super(key: key);

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  final _pageState = PageState();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController namePriceController =
      TextEditingController();

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
      subTitle: 'Cài đặt',
      title: 'Cài đặt / Thông tin liên lạc',
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
                  GoBackButton(
                    onPressed: () {
                      navigateTo(settingManageRoute);
                    },
                  ),
                  titleAddNoti(),
                  contentNoti(context)
                ],
              ),
            );
          }),
    );
  }

  Container contentNoti(BuildContext context) {
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
          ]),
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customerAndTasker(),
              Container(
                width: 1,
                color: AppColor.shade1,
                height: MediaQuery.of(context).size.height / 4,
              ),
              Flexible(
                flex: 8,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: LineContent(
                        title: 'Kênh liên lạc',
                        line1a: 'Số điện thoại',
                        line1b: '0335475756',
                        line2a: 'Địa chỉ',
                        line2b:
                            '358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa',
                        line3a: 'Email: ',
                        line3b: 'grugru@gmail.com'),
                  ),
                ),
              ),
            ],
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

  Widget customerAndTasker() {
    return Flexible(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColor.primary2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 42,
                  vertical: 10,
                ),
                child: Text(
                  'Khách hàng',
                  style: AppTextTheme.mediumBodyText(AppColor.text2),
                ),
              ),
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: AppColor.text2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 29.5,
                  vertical: 10,
                ),
                child: Text(
                  'Người giúp việc',
                  style: AppTextTheme.mediumBodyText(AppColor.text3),
                ),
              ),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }

  Padding titleAddNoti() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Thông tin liên lạc',
              style: AppTextTheme.mediumBigText(AppColor.text3),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: AppColor.primary2,
                  width: 1,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(children: [
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
                )
              ]),
            ),
            onPressed: () {
              navigateTo(editContactRoute);
            },
          ),
        ],
      ),
    );
  }

  Flexible profileUser() {
    return Flexible(
      flex: 9,
      child: Form(
        child: Column(
          children: [
            FormUserWidget(
              showTitle: true,
              isWidth: false,
              controller: nameController,
              hintText: 'Nhập tên thông báo',
              title: 'Tên thông báo',
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Nội dung',
                      style: AppTextTheme.mediumBodyText(AppColor.shadow),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        cursorColor: AppColor.text3,
                        style: AppTextTheme.mediumBodyText(AppColor.text3),
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          fillColor: AppColor.shade1,
                          filled: true,
                          hintStyle:
                              AppTextTheme.mediumBodyText(AppColor.text7),
                          hintText: "Nhập nội dung vào đây...  ",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ]),
            )
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
          style: AppTextTheme.mediumBodyText(AppColor.shadow),
        ),
        TextButton(
          child: Row(
            children: [
              SvgIcon(
                SvgIcons.close,
                color: AppColor.primary2,
                size: 24,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Thêm',
                style: AppTextTheme.mediumBodyText(
                  AppColor.primary2,
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
            ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/images/logo.png",
              width: 100,
              height: 100,
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
                  style: AppTextTheme.mediumBodyText(
                    AppColor.primary2,
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
