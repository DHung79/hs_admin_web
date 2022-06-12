import 'package:flutter/material.dart';
import '/core/admin/model/admin_model.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/app_theme.dart';
import '../../widgets/go_back_button.dart';
import '../../widgets/form_user_widget.dart';
import '../layout_template/content_screen.dart';

class InfoOrder extends StatefulWidget {
  const InfoOrder({
    Key? key,
  }) : super(key: key);

  @override
  State<InfoOrder> createState() => _InfoOrderState();
}

class _InfoOrderState extends State<InfoOrder> {
  final _pageState = PageState();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController namePriceController =
      TextEditingController();

  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  late final TextEditingController numberPhoneController =
      TextEditingController();
  bool money = false;
  bool showProfileTasker = false;
  bool showProfileCustomer = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      return AppColor.text7;
    }
    return AppColor.text7;
  }

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
       route: orderManagementRoute,
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage();
      },
      subTitle: 'Quản lí đặt hàng',
      title: 'Quản lí đặt hàng / Thông tin đơn hàng',
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
                      navigateTo(orderManagementRoute);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Thông tin đơn hàng',
                        style: AppTextTheme.mediumBigText(AppColor.text3),
                      ),
                    ),
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
                    Container(
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
                          imageUser(),
                          Container(
                            width: 1,
                            height: MediaQuery.of(context).size.height / 1.7,
                            color: AppColor.shade1,
                            margin:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                          ),
                          profileUser(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      width: 164,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(50, 20),
                          ),
                          onPressed: () {},
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 16,
                            ),
                            child: Row(
                              children: [
                                SvgIcon(
                                  SvgIcons.close,
                                  color: AppColor.text8,
                                  size: 24,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Hủy đơn hàng',
                                  style: AppTextTheme.mediumBodyText(
                                      AppColor.text8),
                                )
                              ],
                            ),
                          )),
                    )
                  ]),
                ],
              ),
            );
          }),
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

  Flexible profileUser() {
    return Flexible(
      flex: 9,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 450,
        width: MediaQuery.of(context).size.width,
        child: ListView(children: [
          Text(
            'Thông tin dịch vụ',
            style: AppTextTheme.normalHeaderTitle(AppColor.shadow),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                'Tran thai',
                style: AppTextTheme.normalText(AppColor.text8),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Tran thai',
                style: AppTextTheme.headerTitle(AppColor.primary2),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                '(Người giúp việc đã nhận việc)',
                style: AppTextTheme.normalText(AppColor.text3),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      'Dichj vu',
                      style: AppTextTheme.normalText(AppColor.text8),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Don dep nha cua',
                      style: AppTextTheme.normalText(AppColor.text3),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      'Dichj vu',
                      style: AppTextTheme.normalText(AppColor.text8),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Don dep nha cua',
                      style: AppTextTheme.normalText(AppColor.text3),
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      'Dichj vu',
                      style: AppTextTheme.normalText(AppColor.text8),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Don dep nha cua',
                      style: AppTextTheme.normalText(AppColor.text3),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 1,
                child: Row(
                  children: [
                    Text(
                      'Dichj vu',
                      style: AppTextTheme.normalText(AppColor.text8),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Don dep nha cua',
                      style: AppTextTheme.normalText(AppColor.text3),
                    )
                  ],
                ),
              )
            ],
          ),
          Container(
            height: 1,
            color: AppColor.shade1,
            margin: const EdgeInsets.symmetric(vertical: 24.5),
          ),
          Text(
            'Thông tin dịch vụ',
            style: AppTextTheme.normalHeaderTitle(AppColor.shadow),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                color: AppColor.text5,
                width: 4,
                margin: const EdgeInsets.only(right: 16),
              ),
              Text(
                'Thông tin cơ bản:',
                style: AppTextTheme.normalText(AppColor.shadow),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        'Dia chi: ',
                        style: AppTextTheme.normalText(AppColor.text8),
                      ),
                      Text(
                        '358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa',
                        style: AppTextTheme.normalText(AppColor.text3),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        'Dia chi: ',
                        style: AppTextTheme.normalText(AppColor.text8),
                      ),
                      Text(
                        '358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa',
                        style: AppTextTheme.normalText(AppColor.text3),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        'Dia chi:',
                        style: AppTextTheme.normalText(AppColor.text8),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa',
                        style: AppTextTheme.normalText(AppColor.text3),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        'Dia chi:',
                        style: AppTextTheme.normalText(AppColor.text8),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa',
                        style: AppTextTheme.normalText(AppColor.text3),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 150,
                color: AppColor.text5,
                width: 4,
                margin: const EdgeInsets.only(right: 16),
              ),
              Text(
                'Yêu cầu từ khách hàng:',
                style: AppTextTheme.normalText(AppColor.shadow),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Ghi chu:',
                        style: AppTextTheme.normalText(AppColor.text8),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Text(
                        '358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa',
                        style: AppTextTheme.normalText(AppColor.text3),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dia chi: ',
                        style: AppTextTheme.normalText(AppColor.text8),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        children: [
                          Text(
                            'Lau ghe rong',
                            style: AppTextTheme.normalText(AppColor.text3),
                          ),
                          Text(
                            'Lau ghe rong',
                            style: AppTextTheme.normalText(AppColor.text3),
                          ),
                          Text(
                            'Lau ghe rong',
                            style: AppTextTheme.normalText(AppColor.text3),
                          ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        'Dia chi:',
                        style: AppTextTheme.normalText(AppColor.text8),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa',
                        style: AppTextTheme.normalText(AppColor.text3),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Text(
                        'Dia chi:',
                        style: AppTextTheme.normalText(AppColor.text8),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        '358/12/33 Lư Cấm Ngọc Hiệp Nha Trang Khánh Hòa',
                        style: AppTextTheme.normalText(AppColor.text3),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          Container(
            color: AppColor.shade1,
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 24.5),
          ),
          Text(
            'Thông tin thanh toán',
            style: AppTextTheme.normalHeaderTitle(AppColor.shadow),
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                'Hình thức 1:',
                style: AppTextTheme.normalText(AppColor.text8),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Momo',
                style: AppTextTheme.normalText(AppColor.text3),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                'Hình thức 2:',
                style: AppTextTheme.normalText(AppColor.text8),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                'Tiền mặt',
                style: AppTextTheme.normalText(AppColor.text3),
              ),
            ],
          ),
          Container(
            height: 1,
            color: AppColor.shade1,
            margin: const EdgeInsets.symmetric(vertical: 24.5),
          ),
          Text(
            'Thông tin khác',
            style: AppTextTheme.normalHeaderTitle(AppColor.shadow),
          ),
          const SizedBox(
            height: 16,
          ),
          Column(
            children: [
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          'Người tạo:',
                          style: AppTextTheme.normalText(AppColor.text8),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          'vinhkygm@gmail.com',
                          style: AppTextTheme.normalText(AppColor.text3),
                        )
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Row(
                      children: [
                        Text(
                          'Ngày tạo:',
                          style: AppTextTheme.normalText(AppColor.text8),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '13/05/2022',
                          style: AppTextTheme.normalText(AppColor.text3),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Text(
                    'Cập nhật gần nhất:',
                    style: AppTextTheme.normalText(AppColor.text8),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    '13/05/2022',
                    style: AppTextTheme.normalText(AppColor.text3),
                  )
                ],
              ),
            ],
          )
        ]),
      ),
    );
  }

  Column option() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Container(
                width: 4,
                color: AppColor.primary2,
                height: 230,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lựa chọn 1',
                            style: AppTextTheme.mediumHeaderTitle(
                              AppColor.text1,
                            ),
                          ),
                          TextButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Row(children: [
                                SvgIcon(
                                  SvgIcons.delete,
                                  color: AppColor.text7,
                                  size: 24,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Xóa',
                                  style: AppTextTheme.mediumBodyText(
                                      AppColor.text7),
                                )
                              ]),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 1,
                            child: FormUserWidget(
                              padding: const EdgeInsets.all(0),
                              controller: namePriceController,
                              hintText: 'Nhập tên giá',
                              isWidth: true,
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Flexible(
                            flex: 1,
                            child: FormUserWidget(
                              padding: const EdgeInsets.only(left: 16.0),
                              controller: namePriceController,
                              hintText: 'Ghi chú',
                              isWidth: true,
                            ),
                          )
                        ],
                      ),
                    ),
                    FormUserWidget(
                      padding: const EdgeInsets.fromLTRB(
                        16.0,
                        16.0,
                        0,
                        16.0,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgIcon(
                          SvgIcons.dollar,
                          color: AppColor.text5,
                          size: 24,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'VND',
                          style: AppTextTheme.mediumBodyText(AppColor.text3),
                        ),
                      ),
                      isWidth: false,
                      controller: nameController,
                      hintText: 'Nhập giá',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Row(
                        children: [
                          Flexible(
                            flex: 9,
                            child: FormUserWidget(
                              padding: const EdgeInsets.all(0),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Giờ',
                                  style: AppTextTheme.mediumBodyText(
                                      AppColor.text3),
                                ),
                              ),
                              isWidth: false,
                              controller: nameController,
                              hintText: 'Nhập số lượng',
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Flexible(
                            flex: 2,
                            child: InkWell(
                              onTap: () {},
                              child: Container(
                                color: AppColor.shade1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 13,
                                    horizontal: 16,
                                  ),
                                  child: Row(children: [
                                    Text(
                                      'Theo giờ',
                                      style: AppTextTheme.mediumBodyText(
                                        AppColor.text3,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SvgIcon(
                                      SvgIcons.info1,
                                      color: AppColor.shadow,
                                      size: 24,
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Padding priceAndAdd() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Giá',
            style: AppTextTheme.mediumBodyText(AppColor.shadow),
          ),
          TextButton(
            child: Row(
              children: [
                SvgIcon(
                  SvgIcons.close,
                  color: AppColor.primary2,
                  size: 24,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Thêm',
                  style: AppTextTheme.mediumBodyText(
                    AppColor.primary2,
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Flexible imageUser() {
    return Flexible(
      flex: 2,
      child: Column(
        children: [
          profileOrder(
              customer: 'Khách hàng',
              name: 'Nguyễn Đức Hoàng Phi',
              onPressed: () {
                setState(() {
                  showProfileCustomer = true;
                });
              }),
          Divider(
            color: AppColor.shade1,
            height: 24.5,
          ),
          profileOrder(
            customer: 'Người giúp việc',
            name: 'Nguyễn Phúc Vĩnh Kỳ',
            onPressed: () {
              setState(() {
                showProfileTasker = true;
              });
            },
          ),
        ],
      ),
    );
  }

  Container profileOrder({
    required String customer,
    required String name,
    required void Function()? onPressed,
  }) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            customer,
            style: AppTextTheme.normalHeaderTitle(AppColor.shadow),
          ),
          const SizedBox(
            height: 10,
          ),
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
            name,
            style: AppTextTheme.mediumBodyText(
              AppColor.text3,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(50, 20),
            ),
            onPressed: onPressed,
            child: Text(
              'Xem thêm',
              style: AppTextTheme.subText(AppColor.text5),
            ),
          ),
        ],
      ),
    );
  }

  void _fetchDataOnPage() {}
}
