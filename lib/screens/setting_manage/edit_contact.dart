import 'dart:html';

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
import '../../widgets/profile_item_widget.dart';
import '../layout_template/content_screen.dart';

class EditContact extends StatefulWidget {
  const EditContact({Key? key}) : super(key: key);

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
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
      title: 'Cài đặt / Thông tin liên lạc / Chỉnh sửa thông tin liên lạc',
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
              const SizedBox(
                width: 10,
              ),
              Flexible(
                flex: 8,
                child: Container(
                  child: Column(children: [
                    listButton(),
                    const SizedBox(
                      height: 10,
                    ),
                    FormUserWidget(
                      controller: nameController,
                      hintText: 'Nhập tên',
                      isWidth: false,
                      title: 'Tên',
                      showTitle: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hình thức',
                            style: WebTextTheme()
                                .mediumBodyText(WebColor.shadowColor),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: WebColor.shapeColor1),
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Số điện thoại',
                                  style: WebTextTheme()
                                      .mediumBodyText(WebColor.textColor3),
                                ),
                                SvgIcon(
                                  SvgIcons.bell,
                                  color: WebColor.shadowColor,
                                  size: 24,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    FormUserWidget(
                      controller: nameController,
                      hintText: 'Nhập số điện thoại',
                      isWidth: false,
                      title: 'Số điện thoại',
                      showTitle: true,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding listButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          editContactButton(onPressed: () {}),
          const SizedBox(
            width: 16,
          ),
          editContactButton(onPressed: () {}),
          const SizedBox(
            width: 16,
          ),
          editContactButton(onPressed: () {}),
          const SizedBox(
            width: 16,
          ),
          editContactButton(onPressed: () {}),
          const SizedBox(
            width: 16,
          ),
          editContactButton(isAddButton: true, onPressed: () {}),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
    );
  }

  TextButton editContactButton(
      {bool isAddButton = false, required void Function()? onPressed}) {
    return TextButton(
      style: TextButton.styleFrom(
          shadowColor: const Color.fromRGBO(79, 117, 140, 0.16),
          elevation: 16.0,
          padding: EdgeInsets.zero,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          )),
      onPressed: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: isAddButton ? 13 : 16, horizontal: isAddButton ? 13 : 21),
        child: isAddButton
            ? SvgIcon(
                SvgIcons.bell,
                color: WebColor.textColor7,
                size: 24,
              )
            : Text(
                1.toString(),
                style: WebTextTheme().mediumBodyText(WebColor.textColor3),
              ),
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
                backgroundColor: WebColor.primaryColor2,
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
                  style: WebTextTheme().mediumBodyText(WebColor.textColor2),
                ),
              ),
              onPressed: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: WebColor.textColor2,
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
                  style: WebTextTheme().mediumBodyText(WebColor.textColor3),
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
              'Chỉnh sửa thông tin liên lạc',
              style: WebTextTheme().mediumBigText(WebColor.textColor3),
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
                text: 'Thêm',
                onPressed: () {},
              )
            ],
          )
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
                      style:
                          WebTextTheme().mediumBodyText(WebColor.shadowColor),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      child: TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        minLines: 1,
                        cursorColor: WebColor.textColor3,
                        style:
                            WebTextTheme().mediumBodyText(WebColor.textColor3),
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
                          fillColor: WebColor.shapeColor1,
                          filled: true,
                          hintStyle: WebTextTheme()
                              .mediumBodyText(WebColor.textColor7),
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
