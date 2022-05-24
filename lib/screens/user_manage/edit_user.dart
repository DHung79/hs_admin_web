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

class EditUser extends StatefulWidget {
  const EditUser({Key? key}) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
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
      title: 'Quản lí người dùng/Chỉnh sửa thông tin người dùng',
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
                      children: [addUser(), buttonAuth()],
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

  Row buttonAuth() {
    return Row(
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
    );
  }

  Padding addUser() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'THÊM NGƯỜI DÙNG',
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
          const SizedBox(
            width: 10,
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

  Flexible profileUser() {
    return Flexible(
      flex: 4,
      child: Form(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: Column(
              children: [
                FormUserWidget(
                  showTitle: true,
                  isWidth: false,
                  controller: nameController,
                  hintText: 'Nhập tên người dùng',
                  title: 'Tên',
                ),
                FormUserWidget(
                  showTitle: true,
                  isWidth: false,
                  controller: addressController,
                  hintText: 'Nhập địa chỉ',
                  title: 'Địa chỉ',
                ),
                const DropdownWidget(),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                FormUserWidget(
                  showTitle: true,
                  isWidth: false,
                  controller: emailController,
                  hintText: 'Nhập email',
                  title: 'Email',
                ),
                FormUserWidget(
                  showTitle: true,
                  isWidth: false,
                  controller: numberPhoneController,
                  hintText: 'Nhập số điện thoại',
                  title: 'Số điện thoại',
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }

  Flexible imageUser() {
    return Flexible(
      flex: 1,
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
