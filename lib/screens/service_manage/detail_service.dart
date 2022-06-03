import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/admin/model/admin_model.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/app_theme.dart';
import '../../widgets/go_back_button.dart';
import '../../widgets/line_content.dart';
import '../layout_template/content_screen.dart';

class DetailService extends StatefulWidget {
  const DetailService({Key? key}) : super(key: key);

  @override
  State<DetailService> createState() => _DetailServiceState();
}

class _DetailServiceState extends State<DetailService> {
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
      subTitle: 'Quản lí người dùng',
      title: 'Quản lí người dùng',
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
                      navigateTo(serviceManageRoute);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        addUser(),
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
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 10),
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
                                  style: AppTextTheme.mediumBodyText(
                                      AppColor.primary2),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  formprofile(context),
                  const SizedBox(
                    height: 29,
                  ),
                  deleteUser()
                ],
              ),
            );
          }),
    );
  }

  Row deleteUser() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        TextButton(
          child: Row(children: [
            SvgIcon(
              SvgIcons.delete,
              color: AppColor.text8,
              size: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Xóa người dùng',
              style: AppTextTheme.mediumBodyText(AppColor.text8),
            ),
          ]),
          onPressed: () {},
        )
      ],
    );
  }

  Padding addUser() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'Thông tin người dùng',
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
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageUser(),
          Container(
            width: 1,
            height: MediaQuery.of(context).size.height / 2,
            color: AppColor.shade1,
            margin: const EdgeInsets.symmetric(horizontal: 16),
          ),
          profileUser(),
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
      child: SizedBox(
        height: 400,
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView(
            shrinkWrap: true,
            controller: ScrollController(keepScrollOffset: true),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    infoDetail(),
                    Container(
                      height: 1,
                      color: AppColor.shade1,
                      margin: const EdgeInsets.symmetric(vertical: 24),
                    ),
                    priceService(),
                    Container(
                      height: 1,
                      color: AppColor.shade1,
                      margin: const EdgeInsets.symmetric(vertical: 24),
                    ),
                    payments(),
                    Container(
                      height: 1,
                      color: AppColor.shade1,
                      margin: const EdgeInsets.symmetric(vertical: 24),
                    ),
                    const LineContent(
                      title: 'Thông tin khác',
                      line1a: 'Tham gia hệ thống: ',
                      line1b: '17/12/2018',
                      line2a: 'Người cập nhật: ',
                      line2b: 'Julies Nguyễn',
                      line3a: 'Cập nhật lần cuối: ',
                      line3b: '23/04/2022',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column payments() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hình thức thanh toán',
          style: AppTextTheme.normalHeaderTitle(AppColor.shadow),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            lineInfo(name: 'Hình thức 1:', description: 'Momo'),
            const SizedBox(
              width: 24,
            ),
            lineInfo(name: 'Hình thức 2:', description: 'Tiền mặt'),
          ],
        )
      ],
    );
  }

  Column priceService() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Giá',
          style: AppTextTheme.normalHeaderTitle(AppColor.shadow),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            lineInfo(name: 'Tên:', description: '2 Phòng'),
            const SizedBox(
              width: 24,
            ),
            lineInfo(name: 'Giá thành:', description: '200.000 VND'),
            const SizedBox(
              width: 24,
            ),
            lineInfo(name: 'Tính theo:', description: 'Theo giờ'),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            lineInfo(name: 'Tên:', description: '3 Phòng'),
            const SizedBox(
              width: 24,
            ),
            lineInfo(name: 'Giá thành:', description: '400.000 VND'),
            const SizedBox(
              width: 24,
            ),
            lineInfo(name: 'Tính theo:', description: 'Theo giờ'),
          ],
        ),
      ],
    );
  }

  Row lineInfo({
    required String name,
    required String description,
  }) {
    return Row(
      children: [
        Text(
          name,
          style: AppTextTheme.normalText(AppColor.text8),
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          description,
          style: AppTextTheme.normalText(AppColor.text3),
        )
      ],
    );
  }

  Column infoDetail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Thông tin chi tiết',
          style: AppTextTheme.normalHeaderTitle(AppColor.shadow),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Text(
              'Loại dịch vụ:',
              style: AppTextTheme.normalText(AppColor.text8),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              'Dọn dẹp nhà',
              style: AppTextTheme.normalText(AppColor.text3),
            )
          ],
        )
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
              'Dọn dẹp nhà cửa theo giờ',
              style: AppTextTheme.mediumBodyText(AppColor.text3),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchDataOnPage() {}
}
