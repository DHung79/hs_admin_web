import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/admin/model/admin_model.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import 'package:hs_admin_web/widgets/home_widget/back_button_widget.dart';
import 'package:hs_admin_web/widgets/home_widget/background_button_widget.dart';
import 'package:hs_admin_web/widgets/home_widget/dropdown_widget.dart';
import 'package:hs_admin_web/widgets/home_widget/line_content.dart';
import 'package:hs_admin_web/widgets/input_widget.dart';
import '../../configs/svg_constants.dart';
import '../../configs/text_theme.dart';
import '../../configs/themes.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../widgets/home_widget/form_user_widget.dart';
import '../layout_template/content_screen.dart';

class InfoUser extends StatefulWidget {
  const InfoUser({Key? key}) : super(key: key);

  @override
  State<InfoUser> createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
  final _pageState = PageState();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  late final TextEditingController numberPhoneController =
      TextEditingController();
  final bool _checkSearch = true;
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
      name: 'Quản lí người dùng',
      title: 'Quản lí người dùng / Xem thông tin người dùng',
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
                      navigateTo(userManageRoute);
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
                            side: const BorderSide(
                              color: WebColor.primaryColor2,
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
                                  color: WebColor.primaryColor2,
                                  size: 24,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Chỉnh sửa',
                                  style: WebTextTheme()
                                      .mediumBodyText(WebColor.primaryColor2),
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
              color: WebColor.testColor8,
              size: 24,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              'Xóa người dùng',
              style: WebTextTheme().mediumBodyText(WebColor.testColor8),
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
        style: WebTextTheme().mediumBigText(WebColor.textColor3),
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
            color: WebColor.shapeColor1,
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

  Widget profileUser() {
    return Expanded(
      flex: 4,
      child: SizedBox(
        height: 400,
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView(
            shrinkWrap: true,
            // scrollDirection: Axis.vertical,
            controller: ScrollController(keepScrollOffset: true),
            children: [
              const LineContent(
                title: 'Thông tin liên lạc',
                line1a: 'Số điện thoại: ',
                line1b: '0385140807',
                line2a: 'Địa chỉ: ',
                line2b: '358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa',
                line3a: 'Email: ',
                line3b: 'nguyenduchoangphi922016@gmail.com',
              ),
              Container(
                height: 1,
                color: WebColor.shapeColor1,
                margin: const EdgeInsets.symmetric(vertical: 24),
              ),
              const LineContent(
                even: true,
                title: 'Thông tin thanh toán',
                line1a: 'Số tiền hiện tại: ',
                line1b: '1.000 VNĐ',
                line2a: 'Hình thức thành toán: ',
                line2b: 'Thẻ ngân hàng',
                line3a: 'Tổng số tiền: ',
                line3b: '2.000.000 VNĐ',
                line4a: 'Số thẻ: ',
                line4b: '423445798574598',
              ),
              Container(
                height: 1,
                color: WebColor.shapeColor1,
                margin: const EdgeInsets.symmetric(vertical: 24),
              ),
              const LineContent(
                even: true,
                title: 'Thông tin dịch vụ',
                line1a: 'Dịch vụ đã sử dụng: ',
                line1b: '44 lần',
                line2a: 'Thất bại: ',
                line2b: '14 lần',
                line3a: 'Thành công: ',
                line3b: '30 lần',
                line4a: 'Tỉ lệ: ',
                line4b: '68,2%',
              ),
              Container(
                height: 1,
                color: WebColor.shapeColor1,
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
      ),
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
            Text(
              'Nancy Jewel McDonie',
              style: WebTextTheme().mediumBodyText(WebColor.textColor3),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgIcon(
                      SvgIcons.comment,
                      color: WebColor.testColor5,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Nhắn tin',
                      style: WebTextTheme().mediumBodyText(
                        WebColor.testColor5,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _fetchDataOnPage() {}
}
