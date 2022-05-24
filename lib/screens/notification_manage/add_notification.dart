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

class AddNotification extends StatefulWidget {
  const AddNotification({Key? key}) : super(key: key);

  @override
  State<AddNotification> createState() => _AddNotificationState();
}

class _AddNotificationState extends State<AddNotification> {
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
      name: 'Quản lí thông báo đẩy',
      title: 'Quản lí thông báo đẩy / Thêm thông báo đẩy',
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
                      navigateTo(notificationManageRoute);
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
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
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
          const SizedBox(
            width: 10,
          ),
          profileUser(),
        ],
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
              'Thêm thông báo đẩy',
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
