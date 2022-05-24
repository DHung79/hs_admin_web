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

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  final _pageState = PageState();
  late final TextEditingController nameController = TextEditingController();
  late final TextEditingController namePriceController =
      TextEditingController();

  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController addressController = TextEditingController();
  late final TextEditingController numberPhoneController =
      TextEditingController();
  late bool _checkSearch = true;
  bool money = false;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
    };
    if (states.any(interactiveStates.contains)) {
      return WebColor.testColor7;
    }
    return WebColor.textColor7;
    ;
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
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage();
      },
      name: 'Quản lí dịch vụ',
      title: 'Quản lí dịch vụ',
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
                      navigateTo(serviceManageRoute);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Thêm dịch vụ',
                            style: WebTextTheme()
                                .mediumBigText(WebColor.textColor3),
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
                  ),
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
                        const SizedBox(
                          width: 10,
                        ),
                        profileUser(),
                      ],
                    ),
                  )
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
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: ListView(
            shrinkWrap: true,
            children: [
              FormUserWidget(
                showTitle: true,
                isWidth: false,
                controller: nameController,
                hintText: 'Nhập tên dịch vụ',
                title: 'Tên',
              ),
              const DropdownWidget(),
              Column(
                children: [
                  priceAndAdd(),
                  const SizedBox(
                    height: 8,
                  ),
                  option(),
                  const SizedBox(
                    height: 24,
                  ),
                  option(),
                  const SizedBox(
                    height: 25,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hình thức thanh toán',
                          style: WebTextTheme().mediumBodyText(
                            WebColor.shadowColor,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Container(
                              width: 150,
                              decoration: BoxDecoration(
                                color: WebColor.shapeColor1,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 16),
                              child: Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    value: money,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        money = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  Text(
                                    'Tiền mặt',
                                    style: WebTextTheme()
                                        .mediumBodyText(WebColor.textColor3),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 13,
                            ),
                            Container(
                              width: 148,
                              decoration: BoxDecoration(
                                color: WebColor.shapeColor1,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 13, horizontal: 16),
                              child: Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.white,
                                    fillColor:
                                        MaterialStateProperty.resolveWith(
                                            getColor),
                                    value: money,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        money = value!;
                                      });
                                    },
                                  ),
                                  const SizedBox(
                                    width: 13,
                                  ),
                                  Text(
                                    'Momo',
                                    style: WebTextTheme()
                                        .mediumBodyText(WebColor.textColor3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
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
                color: WebColor.primaryColor2,
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
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Lựa chọn 1',
                            style: WebTextTheme().mediumHeaderAndTitle(
                              WebColor.textColor1,
                            ),
                          ),
                          TextButton(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 10),
                              child: Row(children: [
                                SvgIcon(
                                  SvgIcons.delete,
                                  color: WebColor.textColor7,
                                  size: 24,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Xóa',
                                  style: WebTextTheme()
                                      .mediumBodyText(WebColor.textColor7),
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
                              padding: EdgeInsets.all(0),
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
                              padding: EdgeInsets.only(left: 16.0),
                              controller: namePriceController,
                              hintText: 'Ghi chú',
                              isWidth: true,
                            ),
                          )
                        ],
                      ),
                    ),
                    FormUserWidget(
                      padding: EdgeInsets.fromLTRB(
                        16.0,
                        16.0,
                        0,
                        16.0,
                      ),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgIcon(
                          SvgIcons.dollar1,
                          color: WebColor.testColor5,
                          size: 24,
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'VND',
                          style: WebTextTheme()
                              .mediumBodyText(WebColor.textColor3),
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
                              padding: EdgeInsets.all(0),
                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Giờ',
                                  style: WebTextTheme()
                                      .mediumBodyText(WebColor.textColor3),
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
                                color: WebColor.shapeColor1,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 13,
                                    horizontal: 16,
                                  ),
                                  child: Row(children: [
                                    Text(
                                      'Theo giờ',
                                      style: WebTextTheme().mediumBodyText(
                                        WebColor.textColor3,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    SvgIcon(
                                      SvgIcons.addMoney,
                                      color: WebColor.shadowColor,
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
      ),
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
