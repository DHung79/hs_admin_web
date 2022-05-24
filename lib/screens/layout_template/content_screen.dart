import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hs_admin_web/core/admin/bloc/admin_bloc.dart';
import 'package:hs_admin_web/core/admin/model/admin_model.dart';
import 'package:hs_admin_web/screens/navigationbar/appbar.dart';
import 'package:hs_admin_web/widgets/home_widget/warning_widget.dart';
import 'package:hs_admin_web/widgets/profile_item_widget.dart';
import '../../configs/svg_constants.dart';
import '../../configs/text_theme.dart';
import '../../configs/themes.dart';
import '../../configs/validator_text.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../routes/route_names.dart';
import '../../widgets/home_widget/line_content.dart';
import '../navigationbar/sidebar.dart';

class PageTemplate extends StatefulWidget {
  final Widget child;
  final PageState? pageState;
  final void Function(AdminModel?) onUserFetched;
  final Widget? navItem;
  final Widget? tabTitle;
  final int? currentTab;
  final Widget? leading;
  final Widget? drawer;
  final List<Widget>? actions;
  final double elevation;
  final double appBarHeight;
  final Widget? flexibleSpace;
  final bool showAppBar;
  final void Function() onFetch;
  final Widget? appBar;
  final String title;
  final String name;
  bool showProfileTasker;
  bool showProfileTasker2;
  bool showProfileCustomer;
  bool warningDelete;
  bool deleteService;

  PageTemplate({
    Key? key,
    this.deleteService = false,
    this.showProfileTasker = false,
    this.showProfileTasker2 = false,
    this.showProfileCustomer = false,
    this.warningDelete = false,
    required this.child,
    this.pageState,
    required this.onUserFetched,
    this.navItem,
    this.tabTitle,
    this.currentTab,
    this.leading,
    this.drawer,
    this.actions,
    this.elevation = 0,
    this.appBarHeight = 56,
    this.flexibleSpace,
    this.showAppBar = true,
    required this.onFetch,
    this.appBar,
    required this.title,
    required this.name,
  }) : super(key: key);

  @override
  State<PageTemplate> createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  late AuthenticationBloc _authenticationBloc;
  Future<AdminModel>? _currentUser;
// int _totalNotifications;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  bool showNoti = false;
  final _taskerBloc = AdminBloc();
  bool _showProfile = false;
  bool _logOut = false;

  List<Reviewer> reviewers = [
    Reviewer(
        nameReviewer: 'Ngo Anh Duong',
        comment: '"Quá tuyệt vời, quá nice"',
        mark: '5.0'),
    Reviewer(
        nameReviewer: 'Ngo Anh Duong',
        comment: '"Quá tuyệt vời, quá nice"',
        mark: '5.0'),
    Reviewer(
        nameReviewer: 'Ngo Anh Duong',
        comment: '"Quá tuyệt vời, quá nice"',
        mark: '5.0'),
    Reviewer(
        nameReviewer: 'Ngo Anh Duong',
        comment: '"Quá tuyệt vời, quá nice"',
        mark: '5.0'),
    Reviewer(
        nameReviewer: 'Ngo Anh Duong',
        comment: '"Quá tuyệt vời, quá nice"',
        mark: '5.0'),
  ];

  @override
  void initState() {
    _authenticationBloc = AuthenticationBlocController().authenticationBloc;
    _authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _taskerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: _authenticationBloc,
      listener: (BuildContext context, AuthenticationState state) async {
        logDebug(state);
        if (state is AuthenticationStart) {
          navigateTo(authenticationRoute);
        } else if (state is UserLogoutState) {
          navigateTo(authenticationRoute);
        } else if (state is AuthenticationFailure) {
          _showError(state.errorCode);
        } else if (state is UserTokenExpired) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                ScreenUtil.t(I18nKey.signInSessionExpired)!,
              ),
            ),
          );
          navigateTo(authenticationRoute);
        } else if (state is AppAutheticated) {
          _authenticationBloc.add(GetUserData());
        } else if (state is SetUserData<AdminModel>) {
          _currentUser = Future.value(state.currentUser);
        }
      },
      child: FutureBuilder(
        future: _currentUser,
        builder: (context, snapshot) {
          return Scaffold(
            key: _key,
            backgroundColor: Colors.white,
            appBar: widget.showAppBar
                ? PreferredSize(
                    preferredSize: Size.fromHeight(widget.appBarHeight),
                    child: widget.appBar ??
                        AppBar(
                          backgroundColor: Colors.white,
                          flexibleSpace: widget.flexibleSpace,
                          centerTitle: widget.currentTab != 0,
                          leading: widget.leading,
                          actions: widget.actions,
                          title: widget.tabTitle,
                          elevation: widget.elevation,
                        ),
                  )
                : null,
            drawer: widget.drawer,
            bottomNavigationBar: widget.navItem,
            body: LayoutBuilder(
              builder: (context, size) {
                return BlocListener<AuthenticationBloc, AuthenticationState>(
                  bloc: AuthenticationBlocController().authenticationBloc,
                  listener: (BuildContext context, AuthenticationState state) {
                    if (state is SetUserData<AdminModel>) {
                      widget.pageState!.currentUser = Future.value(
                        state.currentUser,
                      );
                      // App.of(context)!.setLocale(
                      //   supportedLocales.firstWhere(
                      //       (e) => e.languageCode == state.currentLang),
                      // );
                      widget.onUserFetched(state.currentUser);
                    }
                  },
                  child: Container(
                    color: WebColor.shapeColor1,
                    child: Stack(
                      children: [
                        Stack(
                          children: [
                            Row(
                              children: [
                                const SideBar(),
                                Expanded(
                                    child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      AppBarWidget(
                                        title: widget.title,
                                        name: widget.name,
                                        showProfile: () {
                                          setState(() {
                                            _showProfile = !_showProfile;
                                          });
                                        },
                                      ),
                                      Expanded(child: widget.child),
                                    ],
                                  ),
                                )),
                              ],
                            ),
                            if (_showProfile)
                              Positioned(
                                child: _profile(
                                  onTap: () {
                                    setState(
                                      () {
                                        _logOut = !_logOut;
                                      },
                                    );
                                  },
                                ),
                                right: 24,
                                top: 72,
                              ),
                            if (widget.showProfileTasker) profileTasker(),
                          ],
                        ),
                        if (_logOut)
                          WarningWidget(
                            ask: 'Bạn có chắc muốn đăng xuất',
                            onPressed: () {
                              setState(() {
                                _logOut = false;
                              });
                            },
                          ),
                        if (widget.showProfileTasker2 == true)
                          formprofile(
                              info: 'Thông tin người giúp việc',
                              isTasker: true,
                              name: 'Nguyen Duc Hoang Phi',
                              onPressed: () {
                                setState(() {
                                  widget.showProfileTasker2 = false;
                                  widget.showProfileCustomer = false;

                                  logDebug(
                                      widget.showProfileTasker2.toString() +
                                          'tasker');
                                });
                              }),
                        if (widget.showProfileCustomer == true)
                          formprofile(
                              info: 'Thông tin khách hàng',
                              onPressed: () {
                                setState(() {
                                  widget.showProfileCustomer = false;
                                  widget.showProfileTasker2 = false;

                                  logDebug(widget.showProfileCustomer);
                                });
                              },
                              isTasker: false,
                              name: 'Nguyen Phuc Vinh Ky'),
                        if (widget.warningDelete)
                          WarningWidget(
                            ask:
                                'Bạn có chắc muốn xóa dịch vụ “Dọn dẹp nhà theo giờ”?',
                            onPressed: () {
                              setState(() {
                                widget.warningDelete = false;
                              });
                            },
                          ),
                        if (widget.deleteService)
                          WarningWidget(
                            ask:
                                'Bạn có chắc muốn hủy dịch vụ Dọn dẹp nhà theo giờ của Ngô Ánh Dương?',
                            onPressed: () {
                              setState(() {
                                widget.deleteService = false;
                              });
                            },
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Positioned profileTasker() {
    return Positioned(
        child: Container(
      color: const Color.fromRGBO(0, 0, 0, 0.3),
      child: Center(
          child: Container(
        width: 458,
        height: 953,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Chi tiết đánh giá',
                      style: WebTextTheme()
                          .normalHeaderAndTitle(WebColor.textColor1),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: const Size(24, 24),
                      ),
                      onPressed: () {
                        setState(() {
                          widget.showProfileTasker = false;
                        });
                      },
                      child: SvgIcon(
                        SvgIcons.close,
                        color: WebColor.textColor1,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Column(
              children: [
                const SizedBox(
                  width: 100,
                  height: 100,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      '',
                    ),
                    backgroundColor: Colors.red,
                  ),
                ),
                Text(
                  'Nguyễn Đức Hoàng Phi',
                  style: WebTextTheme().mediumBigText(WebColor.textColor1),
                ),
                const SizedBox(
                  height: 16,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgIcon(
                          SvgIcons.star,
                          color: WebColor.primaryColor2,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SvgIcon(
                          SvgIcons.star,
                          color: WebColor.primaryColor2,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SvgIcon(
                          SvgIcons.star,
                          color: WebColor.primaryColor2,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SvgIcon(
                          SvgIcons.star,
                          color: WebColor.primaryColor2,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        SvgIcon(
                          SvgIcons.star,
                          color: WebColor.primaryColor2,
                          size: 24,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '4.5',
                          style: WebTextTheme().normalHeaderAndTitle(
                            WebColor.textColor1,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      '(643 đánh giá)',
                      style: WebTextTheme().normalText(WebColor.textColor1),
                    )
                  ],
                ),
                infoTaskerJoin(),
                const SizedBox(
                  height: 16,
                ),
                titleMedalTasker(
                  nameMedal: 'Huy hiệu',
                  countMedal: '7 huy hiệu',
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 16,
                    bottom: 16,
                    left: 16,
                  ),
                  child: SingleChildScrollView(
                    child: SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                          medal(
                            title: 'dsdssd',
                            mark: '10',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                typicalRating()
              ],
            ),
          ],
        ),
      )),
    ));
  }

  Container typicalRating() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Đánh giá tiêu biểu',
              style: WebTextTheme().mediumHeaderAndTitle(
                WebColor.textColor1,
              ),
            ),
          ),
          SizedBox(
            height: 119,
            child: ListView.builder(
              controller: ScrollController(keepScrollOffset: true),
              shrinkWrap: true,
              itemCount: reviewers.length,
              itemBuilder: (context, index) {
                return reviewTasker(
                  comment: reviewers[index].comment,
                  nameReviewer: reviewers[index].nameReviewer,
                  mark: reviewers[index].mark,
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Padding reviewTasker({
    required String comment,
    required String nameReviewer,
    required String mark,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comment,
                style: WebTextTheme().normalText(WebColor.textColor1),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                nameReviewer,
                style: WebTextTheme().subText(
                  WebColor.textColor7,
                ),
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              border: Border.all(width: 1, color: WebColor.shapeColor1),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              children: [
                SvgIcon(
                  SvgIcons.star,
                  color: WebColor.primaryColor2,
                  size: 24,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  mark,
                  style: WebTextTheme().normalText(
                    WebColor.textColor1,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Container medal({
    required String title,
    required String mark,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 36),
      padding: const EdgeInsets.only(left: 16),
      child: Column(
        children: [
          Stack(
            children: [
              const SizedBox(
                width: 60,
                height: 60,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(''),
                ),
              ),
              Positioned(
                bottom: 0,
                left: 15,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                    color: WebColor.primaryColor1,
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
                    child: Text(
                      mark,
                      style: WebTextTheme().subText(WebColor.textColor2),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            title,
            style: WebTextTheme().subText(
              WebColor.textColor1,
            ),
          )
        ],
      ),
    );
  }

  Container titleMedalTasker(
      {required String nameMedal, required String countMedal}) {
    return Container(
      padding: const EdgeInsets.only(
          top: 16.0, left: 16.0, bottom: 8.0, right: 16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              nameMedal,
              style: WebTextTheme().mediumHeaderAndTitle(WebColor.textColor1),
            ),
            Text(
              countMedal,
              style: WebTextTheme().normalText(WebColor.primaryColor2),
            )
          ],
        ),
      ),
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

  Container formprofile(
      {required String info,
      required void Function()? onPressed,
      required bool isTasker,
      required String name}) {
    return Container(
      color: const Color.fromRGBO(0, 0, 0, 0.3),
      child: Center(
        child: Container(
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
          width: 1020,
          height: 488,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      info,
                      style: WebTextTheme()
                          .normalHeaderAndTitle(WebColor.textColor1),
                    ),
                    TextButton(
                      onPressed: onPressed,
                      style: TextButton.styleFrom(
                          minimumSize: const Size(24, 24),
                          padding: EdgeInsets.zero),
                      child: SvgIcon(
                        SvgIcons.close,
                        color: WebColor.textColor1,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageUser(
                    isTasker: isTasker,
                    name: name,
                  ),
                  Container(
                    width: 1,
                    height: MediaQuery.of(context).size.height / 2,
                    color: WebColor.shapeColor1,
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  profileUser(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Flexible imageUser({required String name, required bool isTasker}) {
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
              name,
              style: WebTextTheme().mediumBodyText(WebColor.textColor3),
            ),
            const SizedBox(
              width: 10,
            ),
            isTasker
                ? Column(
                    children: [
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
                    ],
                  )
                : Container(),
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

  Container infoTaskerJoin() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            infoTasker(
              title: 'Tham gia từ',
              description: '3/2019',
            ),
            Container(
              color: WebColor.shapeColor1,
              width: 1,
              height: 40,
            ),
            infoTasker(
              title: 'Tham gia từ',
              description: '3/2019',
            ),
            Container(
              color: WebColor.shapeColor1,
              width: 1,
              height: 40,
            ),
            infoTasker(
              title: 'Tham gia từ',
              description: '3/2019',
            ),
          ],
        ),
      ),
    );
  }

  Padding infoTasker({required String title, required String description}) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            title,
            style: WebTextTheme().normalText(WebColor.textColor7),
          ),
          const SizedBox(
            height: 4,
          ),
          Text(
            description,
            style: WebTextTheme().mediumHeaderAndTitle(WebColor.primaryColor1),
          )
        ],
      ),
    );
  }

  _profile({required void Function()? onTap}) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: WebColor.shadowColor.withOpacity(0.16),
              blurStyle: BlurStyle.outer,
              blurRadius: 16,
            )
          ]),
      width: 166,
      height: 168,
      child: Column(
        children: [
          ProfileItemWidget(
            icon: SvgIcons.person,
            title: 'Hồ Sơ',
            onTap: () {},
          ),
          ProfileItemWidget(
            icon: SvgIcons.setting,
            title: 'Cài đặt',
            onTap: () {},
          ),
          ProfileItemWidget(
              icon: SvgIcons.logout, title: 'Đăng xuất', onTap: onTap),
        ],
      ),
    );
  }

  _showError(String errorCode) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(showError(errorCode, context))),
    );
  }
}

class PageContent extends StatelessWidget {
  final AsyncSnapshot<AdminModel> userSnapshot;
  final PageState pageState;
  final void Function()? onFetch;
  final Widget child;

  const PageContent({
    Key? key,
    required this.userSnapshot,
    required this.pageState,
    required this.child,
    this.onFetch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!userSnapshot.hasData) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 8),
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Theme.of(context).textTheme.button!.color,
            ),
          ),
        ),
      );
    }

    if (!pageState.isInitData) {
      if (onFetch != null) onFetch!();
      pageState.isInitData = true;
    }

    return child;
  }
}

class PageState {
  bool isInitData = false;
  Future<AdminModel>? currentUser;
}

class Reviewer {
  String nameReviewer;
  String comment;
  String mark;
  Reviewer({
    required this.nameReviewer,
    required this.comment,
    required this.mark,
  });
}
