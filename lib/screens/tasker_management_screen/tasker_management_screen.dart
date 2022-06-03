import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/admin/model/admin_model.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../core/authentication/auth.dart';
import '../../core/tasker/tasker.dart';
import '../../main.dart';
import '../../theme/app_theme.dart';
import '../layout_template/content_screen.dart';

class TaskerManagementScreen extends StatefulWidget {
  const TaskerManagementScreen({Key? key}) : super(key: key);

  @override
  State<TaskerManagementScreen> createState() => _TaskerManagementScreenState();
}

class _TaskerManagementScreenState extends State<TaskerManagementScreen> {
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
      title: 'Quản lí người giúp việc',
      subTitle: 'Quản lí người giúp việc',
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
                        style: AppTextTheme.mediumBigText(AppColor.text3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _searchBar(),
                          backgroundButton(
                              text: 'Thêm người giúp việc',
                              icon: SvgIcons.expandMore,
                              color: AppColor.primary2),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      // height: 500,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppColor.shade2,
                      ),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: AppColor.shadow.withOpacity(0.24),
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
                                  flex: 1,
                                ),
                                propertyRecords(
                                  flex: 3,
                                  title: 'Tên',
                                  icon: true,
                                ),
                                propertyRecords(
                                  flex: 3,
                                  title: 'Email',
                                  icon: true,
                                ),
                                propertyRecords(
                                  flex: 3,
                                  title: 'Số điện thoại',
                                  icon: true,
                                ),
                                propertyRecords(
                                  flex: 2,
                                  title: 'Hoạt động',
                                ),
                              ],
                            ),
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromRGBO(79, 117, 140, 0.16),
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 16,
                                  offset: Offset(
                                    0.0, // Move to right 10  horizontally
                                    0.0, // Move to bottom 10 Vertically
                                  ),
                                )
                              ],
                              borderRadius: BorderRadius.vertical(
                                bottom: Radius.circular(20),
                              ),
                            ),
                            height: 400,
                            child: Scrollbar(
                              thumbVisibility: true,
                              child: ListView.builder(
                                controller: ScrollController(
                                  keepScrollOffset: true,
                                ),
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return inforTaskerModel(
                                    id: index + 1,
                                    name: '',
                                    numberPhone: '',
                                    activity: false,
                                  );
                                },
                                itemCount: 1,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    footerRecord()
                  ]),
            );
          }),
    );
  }

  Row inforTaskerModel({
    required int id,
    required String name,
    required String numberPhone,
    bool activity = false,
  }) {
    return Row(children: [
      Flexible(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                id.toString(),
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ],
          ),
        ),
      ),
      Flexible(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                name,
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ],
          ),
        ),
      ),
      Flexible(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                numberPhone,
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ],
          ),
        ),
      ),
      Flexible(
        flex: 3,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              activity
                  ? Text(
                      'Hoạt động',
                      style: AppTextTheme.mediumBodyText(
                        AppColor.text7,
                      ),
                    )
                  : Text(
                      'Không hoạt động',
                      style: AppTextTheme.mediumBodyText(
                        AppColor.others1,
                      ),
                    ),
            ],
          ),
        ),
      ),
      Flexible(
        flex: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SvgIcon(
                SvgIcons.info1,
                color: AppColor.shadow,
                size: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              SvgIcon(
                SvgIcons.info1,
                color: AppColor.shadow,
                size: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              SvgIcon(
                SvgIcons.info1,
                color: AppColor.shadow,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    ]);
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
                style: AppTextTheme.normalText(
                  AppColor.text3,
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
                      style: AppTextTheme.normalText(AppColor.text1),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SvgIcon(
                      SvgIcons.checkCircle,
                      color: AppColor.text7,
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
                        color: AppColor.text8,
                        size: 24,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Chỉnh sửa bảng',
                        style: AppTextTheme.mediumBodyText(
                          AppColor.text8,
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
                  SvgIcons.arrowIosBack,
                  size: 24,
                  color: AppColor.inactive1,
                ),
              ),
              const SizedBox(
                width: 28.5,
              ),
              Text(
                '1',
                style: AppTextTheme.normalText(
                  AppColor.text1,
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
                  SvgIcons.callReceived,
                  size: 24,
                  color: AppColor.inactive1,
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }

  Flexible propertyRecords({
    required int flex,
    bool icon = false,
    required String title,
  }) {
    return Flexible(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(children: [
          Text(
            title,
            style: AppTextTheme.mediumHeaderTitle(AppColor.shadow),
          ),
          const SizedBox(
            width: 10,
          ),
          if (icon)
            SvgIcon(
              SvgIcons.filter,
              color: AppColor.text7,
              size: 18,
            ),
        ]),
      ),
    );
  }

  TextButton backgroundButton({
    required String text,
    required SvgIconData icon,
    required Color color,
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
              style: AppTextTheme.mediumBodyText(Colors.white),
            )
          ],
        ),
      ),
      onPressed: () {
        navigateTo(inforTaskerRoute);
      },
    );
  }

  SizedBox _searchBar() {
    return SizedBox(
      width: 265,
      child: TextFormField(
        cursorHeight: 20,
        cursorColor: AppColor.text7,
        style: AppTextTheme.normalText(AppColor.text1),
        decoration: InputDecoration(
          hoverColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: 'Tìm kiếm',
          hintStyle: AppTextTheme.normalText(AppColor.text7),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(4.0),
            child: TextButton(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(50, 30),
              ),
              child: SvgIcon(
                SvgIcons.search,
                color: _checkSearch ? AppColor.text7 : AppColor.primary2,
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
                      color: AppColor.others1,
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
