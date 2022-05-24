import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/admin/model/admin_model.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import 'package:hs_admin_web/screens/order_manage/info_order.dart';
import '../../configs/svg_constants.dart';
import '../../configs/text_theme.dart';
import '../../configs/themes.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../layout_template/content_screen.dart';

class OrderManage extends StatefulWidget {
  bool deleteService;
  OrderManage({Key? key, this.deleteService = false}) : super(key: key);

  @override
  State<OrderManage> createState() => _OrderManageState();
}

class _OrderManageState extends State<OrderManage> {
  final _pageState = PageState();
  late final TextEditingController _searchController = TextEditingController();
  late bool _checkSearch = true;

  List<Order> orders = [
    Order(
        service: 'Dọn dẹp nhà theo giờ',
        total: '230.000 VND',
        customer: 'Ngô Ánh Dương',
        status: 0),
    Order(
        service: 'Dọn dẹp nhà theo giờ',
        total: '230.000 VND',
        customer: 'Ngô Ánh Dương',
        status: 2),
    Order(
        service: 'Dọn dẹp nhà theo giờ',
        total: '230.000 VND',
        customer: 'Ngô Ánh Dương',
        status: 3),
    Order(
        service: 'Dọn dẹp nhà theo giờ',
        total: '230.000 VND',
        customer: 'Ngô Ánh Dương',
        status: 1),
    Order(
        service: 'Dọn dẹp nhà theo giờ',
        total: '230.000 VND',
        customer: 'Ngô Ánh Dương',
        status: 3),
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
      title: 'Quản lí đặt hàng',
      name: 'Quản lí đặt hàng',
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage();
      },
      deleteService: widget.deleteService,
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
                        'Danh sách đơn đặt hàng',
                        style:
                            WebTextTheme().mediumBigText(WebColor.textColor3),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: _searchBar(),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
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
                                    color:
                                        WebColor.shadowColor.withOpacity(0.24),
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
                                  title: 'Dịch vụ',
                                  icon: true,
                                ),
                                propertyRecords(
                                  flex: 4,
                                  title: 'Tổng tiền',
                                  icon: true,
                                ),
                                propertyRecords(
                                  flex: 5,
                                  title: 'Khách hàng',
                                  icon: true,
                                ),
                                propertyRecords(
                                  flex: 4,
                                  title: 'Trạng thái',
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
                                  return infoOrder(
                                      id: index + 1,
                                      service: orders[index].service,
                                      total: orders[index].total,
                                      customer: orders[index].customer,
                                      status: orders[index].status);
                                },
                                itemCount: orders.length,
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

  Row infoOrder({
    required int id,
    required String service,
    required String total,
    required String customer,
    required int status,
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
                style: WebTextTheme().normalText(WebColor.textColor1),
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
                onPressed: () {
                  navigateTo(infoOrderRoute);
                },
                child: Text(
                  service,
                  style: WebTextTheme().normalText(WebColor.textColor1),
                ),
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
                total,
                style: WebTextTheme().normalText(WebColor.textColor1),
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
                customer,
                style: WebTextTheme().normalText(WebColor.textColor1),
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
              status == 0
                  ? Text(
                      'Thành công',
                      style: WebTextTheme().mediumBodyText(
                        Color.fromRGBO(102, 199, 25, 1),
                      ),
                    )
                  : status == 1
                      ? Text(
                          'Đã hủy',
                          style: WebTextTheme().mediumBodyText(
                            WebColor.otherColor1,
                          ),
                        )
                      : status == 2
                          ? Text(
                              'Đã nhận',
                              style: WebTextTheme().mediumBodyText(
                                WebColor.textColor3,
                              ),
                            )
                          : status == 4
                              ? Text(
                                  'Đã nhận',
                                  style: WebTextTheme().mediumBodyText(
                                    WebColor.testColor8,
                                  ),
                                )
                              : Text(
                                  'Đang tiến hành',
                                  style: WebTextTheme().mediumBodyText(
                                    WebColor.primaryColor2,
                                  ),
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
                color: WebColor.shadowColor,
                size: 24,
              ),
              const SizedBox(
                width: 16,
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    widget.deleteService = true;
                  });
                },
                style: TextButton.styleFrom(
                    padding: EdgeInsets.zero, minimumSize: const Size(24, 24)),
                child: SvgIcon(
                  SvgIcons.close,
                  color: WebColor.shadowColor,
                  size: 24,
                ),
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
              style: WebTextTheme().mediumBodyText(Colors.white),
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

class Order {
  final String service;
  final String total;
  final String customer;
  final int status;
  Order({
    required this.service,
    required this.total,
    required this.customer,
    required this.status,
  });
}
