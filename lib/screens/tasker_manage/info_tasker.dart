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

class InfoTasker extends StatefulWidget {
  const InfoTasker({Key? key}) : super(key: key);

  @override
  State<InfoTasker> createState() => _InfoTaskerState();
}

class _InfoTaskerState extends State<InfoTasker> {
  final _pageState = PageState();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  late final TextEditingController numberPhoneController =
      TextEditingController();
  final bool _checkSearch = true;
  late bool isShowProfileTasker = false;
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
      showProfileTasker: isShowProfileTasker,
      name: 'Quản lí người giúp việc',
      title: 'Quản lí người giúp việc',
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
                    navigateTo(taskerManageRoute);
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
                formprofile(),
                const SizedBox(
                  height: 29,
                ),
                deleteUser()
              ],
            ),
          );
        },
      ),
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
        'Thông tin người giúp việc',
        style: WebTextTheme().mediumBigText(WebColor.textColor3),
      ),
    );
  }

  Container formprofile() {
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
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        height: 400,
        child: Scrollbar(
          thumbVisibility: true,
          child: ListView(
            shrinkWrap: true,
            // scrollDirection: Axis.vertical,
            controller: ScrollController(keepScrollOffset: true),
            children: [
              lineContent(
                even: 8,
                title: 'Thông tin cá nhân',
                line1a: 'Số điện thoại: ',
                line1b: '0385140807',
                line2a: 'Địa chỉ: ',
                line2b: '358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa',
                line3a: 'Ngày cấp: ',
                line3b: '19/03/2016',
                line4a: 'Trình độ học vấn: ',
                line4b: '12/12',
                line5a: 'Email: ',
                line5b: 'vinhkygm@gmail.com',
                line6a: 'CMND: ',
                line6b: '80125881',
                line7a: 'Nơi cấp: ',
                line7b: '358/12/33 Lư Cấm Ngọc Hiệp',
                line8a: 'Trình độ tiếng anh: ',
                line8b: 'TOEIC 600',
              ),
              Container(
                height: 1,
                color: WebColor.shapeColor1,
                margin: const EdgeInsets.symmetric(vertical: 24),
              ),
              lineContent(
                even: 4,
                title: 'Thông tin thanh toán',
                line1a: 'Số tiền hiện tại: ',
                line1b: '1.000 VNĐ',
                line2a: 'Hình thức thành toán: ',
                line2b: 'Thẻ ngân hàng',
                line5a: 'Tổng số tiền: ',
                line5b: '2.000.000 VNĐ',
                line6a: 'Số thẻ: ',
                line6b: '423445798574598',
              ),
              Container(
                height: 1,
                color: WebColor.shapeColor1,
                margin: const EdgeInsets.symmetric(vertical: 24),
              ),
              lineContent(
                even: 4,
                title: 'Thông tin công việc',
                line1a: 'Công việc đã nhận: ',
                line1b: '44 lần',
                line2a: 'Thất bại: ',
                line2b: '14 lần',
                line5a: 'Thành công: ',
                line5b: '30 lần',
                line6a: 'Tỉ lệ: ',
                line6b: '68,2%',
              ),
              Container(
                height: 1,
                color: WebColor.shapeColor1,
                margin: const EdgeInsets.symmetric(vertical: 24),
              ),
              lineContent(
                title: 'Thông tin pháp lý',
                line1a: 'Tiền án: ',
                line1b: 'Không',
                line5a: 'Giấy xác thực: ',
                line5b: 'Xem chi tiết',
              ),
              Container(
                height: 1,
                color: WebColor.shapeColor1,
                margin: const EdgeInsets.symmetric(vertical: 24),
              ),
              lineContent(
                title: 'Thông tin công việc',
                line1a: 'Công việc đã nhận: ',
                line1b: '44 lần',
                line5a: 'Thất bại: ',
                line5b: '14 lần',
              ),
              Container(
                height: 1,
                color: WebColor.shapeColor1,
                margin: const EdgeInsets.symmetric(vertical: 24),
              ),
              lineContent(
                even: 3,
                title: 'Thông tin khác',
                line1a: 'Tham gia hệ thống: ',
                line1b: '17/12/2018',
                line2a: 'Người cập nhật: ',
                line2b: 'Julies Nguyễn',
                line5a: 'Cập nhật lần cuối: ',
                line5b: '23/04/2022',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column lineContent({
    int? even,
    required String title,
    required String line1a,
    required String line1b,
    String? line2a,
    String? line2b,
    String? line3a,
    String? line3b,
    String? line4a,
    String? line4b,
    required String line5a,
    required String line5b,
    String? line6a,
    String? line6b,
    String? line7a,
    String? line7b,
    String? line8a,
    String? line8b,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: WebTextTheme().normalHeaderAndTitle(WebColor.shadowColor),
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
                  even == 8
                      ? Column(
                          children: [
                            even == 8 || even == 3 || even == 4
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      lineProfile(
                                        name: line2a!,
                                        description: line2b!,
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 16,
                            ),
                            lineProfile(
                              name: line3a!,
                              description: line3b!,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            lineProfile(
                              name: line4a!,
                              description: line4b!,
                            ),
                          ],
                        )
                      : const SizedBox(),
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
                    name: line5a,
                    description: line5b,
                  ),
                  even == 4 || even == 8
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            lineProfile(
                              name: line6a!,
                              description: line6b!,
                            ),
                          ],
                        )
                      : const SizedBox(),
                  even == 8
                      ? Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            lineProfile(
                              name: line7a!,
                              description: line7b!,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            lineProfile(
                              name: line8a!,
                              description: line8b!,
                            ),
                          ],
                        )
                      : const SizedBox(),
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
          style: WebTextTheme().normalText(WebColor.testColor8),
        ),
        Flexible(
          child: Text(
            description,
            style: WebTextTheme().normalText(WebColor.textColor3),
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
              width: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'ID: 300451841',
                  style: WebTextTheme().normalText(
                    WebColor.testColor8,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                SvgIcon(
                  SvgIcons.comment,
                  color: WebColor.testColor8,
                  size: 24,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SvgIcon(
                  SvgIcons.star,
                  color: WebColor.primaryColor2,
                  size: 24,
                ),
                SvgIcon(
                  SvgIcons.star,
                  color: WebColor.primaryColor2,
                  size: 24,
                ),
                SvgIcon(
                  SvgIcons.star,
                  color: WebColor.primaryColor2,
                  size: 24,
                ),
                SvgIcon(
                  SvgIcons.star,
                  color: WebColor.primaryColor2,
                  size: 24,
                ),
                SvgIcon(
                  SvgIcons.star,
                  color: WebColor.primaryColor2,
                  size: 24,
                ),
                Text(
                  '4.5',
                  style: WebTextTheme().normalHeaderAndTitle(
                    WebColor.textColor3,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              '(643 đánh giá)',
              style: WebTextTheme().normalHeaderAndTitle(
                WebColor.textColor3,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isShowProfileTasker = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgIcon(
                      SvgIcons.starOutline,
                      color: WebColor.testColor8,
                      size: 24,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Chi tiết đánh giá',
                      style: WebTextTheme().normalText(
                        WebColor.testColor8,
                      ),
                    ),
                  ],
                ),
              ),
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
