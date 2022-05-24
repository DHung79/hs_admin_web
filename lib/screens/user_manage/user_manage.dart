import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/admin/model/admin_model.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../configs/svg_constants.dart';
import '../../configs/text_theme.dart';
import '../../configs/themes.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../layout_template/content_screen.dart';

class UserManage extends StatefulWidget {
  const UserManage({Key? key}) : super(key: key);

  @override
  State<UserManage> createState() => _UserManageState();
}

class _UserManageState extends State<UserManage> {
  final _pageState = PageState();
  late final TextEditingController _searchController = TextEditingController();
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
      name: 'Quản lí người dùng',
      title: 'Quản lí người dùng',
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
                        'DANH SÁCH NGƯỜI DÙNG',
                        style:
                            WebTextTheme().mediumBigText(WebColor.textColor3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _searchBar(),
                          backgroundButton(
                            text: 'Thêm người dùng',
                            icon: SvgIcons.keyboardDown,
                            color: WebColor.primaryColor2,
                            onPressed: () {
                              navigateTo(addUserRoute);
                            },
                          ),
                        ],
                      ),
                    ),
                    userRecord(context),
                    footerRecord(),
                  ]),
            );
          }),
    );
  }

  Padding footerRecord() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                'Number on page',
                style: WebTextTheme().normalText(
                  WebColor.textColor3,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                child: InkWell(
                  child: Row(children: [
                    Text(
                      '10',
                      style: WebTextTheme().normalText(WebColor.textColor1),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgIcon(
                      SvgIcons.circleCheck,
                      color: WebColor.textColor7,
                      size: 24,
                    )
                  ]),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: TextButton(
                  onPressed: () {},
                  child: Row(
                    children: [
                      SvgIcon(
                        SvgIcons.barChart,
                        color: WebColor.testColor8,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Chỉnh sửa bảng',
                        style: WebTextTheme().mediumBodyText(
                          WebColor.testColor8,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10), color: Colors.white),
            padding: const EdgeInsets.all(10),
            child: Row(children: [
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(24, 2),
                ),
                onPressed: () {},
                child: SvgIcon(
                  SvgIcons.arrowBack,
                  size: 24,
                  color: WebColor.inactiveColor1,
                ),
              ),
              const SizedBox(
                width: 28.5,
              ),
              Text(
                '1',
                style: WebTextTheme().normalText(
                  WebColor.textColor1,
                ),
              ),
              const SizedBox(
                width: 28.5,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(24, 2),
                ),
                onPressed: () {},
                child: SvgIcon(
                  SvgIcons.arrowTopLeft,
                  size: 24,
                  color: WebColor.inactiveColor1,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Container userRecord(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: WebColor.shapeColor2,
      ),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: WebColor.shadowColor.withOpacity(0.24),
                    blurStyle: BlurStyle.outer,
                    blurRadius: 16)
              ],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                propertyRecords(
                  title: 'No.',
                  widthSize: (MediaQuery.of(context).size.width - 375) * 0.085,
                ),
                propertyRecords(
                  title: 'Tên',
                  widthSize: (MediaQuery.of(context).size.width - 375) * 0.145,
                  icon: true,
                ),
                propertyRecords(
                  title: 'Email',
                  widthSize: (MediaQuery.of(context).size.width - 375) * 0.272,
                  icon: true,
                ),
                propertyRecords(
                  title: 'Số điện thoại',
                  widthSize: (MediaQuery.of(context).size.width - 375) * 0.162,
                  icon: true,
                ),
                propertyRecords(
                  title: 'Địa chỉ',
                  widthSize: (MediaQuery.of(context).size.width - 375) * 0.188,
                  icon: true,
                ),
                propertyRecords(
                  title: 'Hoạt động',
                  widthSize: (MediaQuery.of(context).size.width - 375) * 0.149,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container propertyRecords({
    bool icon = false,
    required double widthSize,
    required String title,
  }) {
    return Container(
      width: widthSize,
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        Text(
          title,
          style: WebTextTheme().mediumHeaderAndTitle(WebColor.shadowColor),
        ),
        const SizedBox(
          width: 10,
        ),
        if (icon)
          SvgIcon(
            SvgIcons.filter,
            color: WebColor.textColor7,
            size: 18,
          ),
      ]),
    );
  }

  TextButton backgroundButton({
    required String text,
    required SvgIconData icon,
    required Color color,
    required onPressed,
  }) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 13,
          horizontal: 16,
        ),
        child: Row(
          children: [
            SvgIcon(
              icon,
              color: Colors.white,
              size: 24,
            ),
            const SizedBox(
              width: 14,
            ),
            Text(
              text,
              style: WebTextTheme().mediumBodyText(Colors.white),
            )
          ],
        ),
      ),
      onPressed: onPressed,
    );
  }

  SizedBox _searchBar() {
    return SizedBox(
      width: 265,
      child: TextFormField(
        cursorHeight: 20,
        cursorColor: WebColor.textColor7,
        style: WebTextTheme().normalText(WebColor.textColor1),
        decoration: InputDecoration(
          hoverColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Tìm kiếm',
          hintStyle: WebTextTheme().normalText(WebColor.textColor7),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
              ),
              child: SvgIcon(
                SvgIcons.search,
                color:
                    _checkSearch ? WebColor.textColor7 : WebColor.primaryColor2,
              ),
              onPressed: () {},
            ),
          ),
          suffixIcon: _checkSearch
              ? null
              : Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(50, 30),
                    ),
                    child: SvgIcon(
                      SvgIcons.close,
                      color: WebColor.otherColor1,
                    ),
                    onPressed: () {
                      setState(() {
                        _searchController.text = '';
                        _checkSearch = true;
                      });
                    },
                  ),
                ),
        ),
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return 'Tìm kiếm';
          }
          return null;
        },
        onChanged: (String value) {
          setState(() {
            if (_searchController.text.isNotEmpty) {
              _checkSearch = false;
            }
          });
        },
        controller: _searchController,
      ),
    );
  }

  void _fetchDataOnPage() {}
}
