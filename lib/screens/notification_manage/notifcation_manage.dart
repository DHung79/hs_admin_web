import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/admin/model/admin_model.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/app_theme.dart';
import '../layout_template/content_screen.dart';

class NotificationManage extends StatefulWidget {
  const NotificationManage({Key? key}) : super(key: key);

  @override
  State<NotificationManage> createState() => _NotificationManageState();
}

class _NotificationManageState extends State<NotificationManage> {
  final _pageState = PageState();
  late final TextEditingController _searchController = TextEditingController();
  late bool _checkSearch = true;
  bool hover = false;

  List<Notification> notifications = [
    Notification(
      name: 'Khuyến mãi tháng 2',
      type: 'Khách Hàng',
      createDay: '02/01/2022',
      editDay: '23/04/2022',
    ),
    Notification(
      name: 'Khuyến mãi tháng 2',
      type: 'Khách Hàng',
      createDay: '02/01/2022',
      editDay: '23/04/2022',
    ),
    Notification(
      name: 'Khuyến mãi tháng 2',
      type: 'Khách Hàng',
      createDay: '02/01/2022',
      editDay: '23/04/2022',
    ),
    Notification(
      name: 'Khuyến mãi tháng 2',
      type: 'Khách Hàng',
      createDay: '02/01/2022',
      editDay: '23/04/2022',
    ),
    Notification(
      name: 'Khuyến mãi tháng 2',
      type: 'Khách Hàng',
      createDay: '02/01/2022',
      editDay: '23/04/2022',
    ),
  ];
  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      title: 'Quản lí thông báo đẩy',
      name: 'Quản lí thông báo đẩy',
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
                    'Danh sách thông báo đẩy',
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
                          text: 'Thêm dịch vụ',
                          icon: SvgIcons.keyboardDown,
                          color: AppColor.primary2,
                        ),
                      ]),
                ),
                Stack(children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
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
                                flex: 2,
                              ),
                              propertyRecords(
                                flex: 5,
                                title: 'Tên',
                                icon: true,
                              ),
                              propertyRecords(
                                flex: 3,
                                title: 'Loại',
                                icon: true,
                              ),
                              propertyRecords(
                                flex: 4,
                                title: 'Ngày tạo',
                                icon: true,
                              ),
                              propertyRecords(
                                flex: 5,
                                title: 'Ngày chỉnh sửa',
                                icon: true,
                              ),
                              propertyRecords(
                                flex: 4,
                                title: 'Hành động',
                              ),
                            ],
                          ),
                        ),
                        Container(
                          constraints: const BoxConstraints(
                            maxHeight: 450,
                            minHeight: 0,
                          ),
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
                                return infoNotification(
                                  id: index + 1,
                                  name: 'Khuyến mãi tháng 2',
                                  type: 'Khách hàng',
                                  createDay: '02/03/2022',
                                  editDay: '22/04/2022',
                                );
                              },
                              itemCount: notifications.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (hover)
                    Positioned(
                      child: contentSale(),
                      bottom: 150,
                      left: 100,
                    )
                ]),
                footerRecord()
              ],
            ),
          );
        },
      ),
    );
  }

  Container contentSale() {
    return Container(
      width: 425,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(79, 117, 140, 0.16),
              blurStyle: BlurStyle.outer,
              blurRadius: 16,
            ),
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Khuyến mãi tháng 2',
            style: AppTextTheme.mediumHeaderTitle(AppColor.text1),
          ),
          const SizedBox(
            height: 16,
          ),
          Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ac eu odio etiam ac cras nisi imperdiet quam. At accumsan, ut nibh diam nullam. Varius felis tincidunt purus ullamcorper praesent elementum duis. Velit arcu hac quis sit sed urna orci tincidunt suspendisse. Nunc lacus dignissim interdum eget ipsum dum eget ipsum...',
            style: AppTextTheme.normalText(AppColor.text3),
          ),
          const SizedBox(
            height: 16,
          ),
          InkWell(
            onTap: () {},
            child: Text(
              'Xem chi tiết',
              style: AppTextTheme.normalText(AppColor.primary2),
            ),
          ),
        ],
      ),
    );
  }

  Row infoNotification({
    required int id,
    required String name,
    required String type,
    required String createDay,
    required String editDay,
  }) {
    return Row(children: [
      Flexible(
        flex: 2,
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
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              TextButton(
                onPressed: () {},
                onHover: (isValue) {
                  setState(() {
                    hover = isValue;
                  });
                },
                child: Text(
                  name,
                  style: AppTextTheme.normalText(AppColor.text1),
                ),
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
                type,
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ],
          ),
        ),
      ),
      Flexible(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                createDay,
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ],
          ),
        ),
      ),
      Flexible(
        flex: 5,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Text(
                editDay,
                style: AppTextTheme.normalText(AppColor.text1),
              ),
            ],
          ),
        ),
      ),
      Flexible(
        flex: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              SvgIcon(
                SvgIcons.addMoney,
                color: AppColor.shadow,
                size: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              SvgIcon(
                SvgIcons.addMoney,
                color: AppColor.shadow,
                size: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              SvgIcon(
                SvgIcons.addMoney,
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
                      SvgIcons.circleCheck,
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
                  SvgIcons.arrowBack,
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
                  SvgIcons.arrowTopLeft,
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
        navigateTo(addNotificationRoute);
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
                color:
                    _checkSearch ? AppColor.text7 : AppColor.primary2,
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

class Notification {
  final String name;
  final String type;
  final String createDay;
  final String editDay;
  Notification({
    required this.name,
    required this.type,
    required this.createDay,
    required this.editDay,
  });
}
