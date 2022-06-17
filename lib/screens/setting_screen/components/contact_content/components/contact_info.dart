import 'package:flutter/material.dart';
import '../../../../../core/authentication/auth.dart';
import '../../../../../core/contact/contact.dart';
import '../../../../../main.dart';
import '../../../../../theme/app_theme.dart';
import '../../../../../widgets/go_back_button.dart';
import '../../../../../widgets/joytech_components/joytech_components.dart';

class ContactInfo extends StatefulWidget {
  final String route;
  final List<ContactInfoModel> listContactInfo;
  const ContactInfo({
    Key? key,
    required this.route,
    required this.listContactInfo,
  }) : super(key: key);

  @override
  State<ContactInfo> createState() => _ContactInfoState();
}

class _ContactInfoState extends State<ContactInfo> {
  final _scrollController = ScrollController();
  bool _isUserContact = true;

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildContact(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: GoBackButton(
            onPressed: () {
              navigateTo(settingRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 17, 10, 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông tin liên lạc',
                style: AppTextTheme.mediumBigText(AppColor.text3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButtonTheme.outlineRounded(
                    constraints: const BoxConstraints(minHeight: 44),
                    color: AppColor.transparent,
                    outlineColor: AppColor.primary2,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.edit,
                            color: AppColor.primary2,
                            size: 24,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Chỉnh sửa',
                              style: AppTextTheme.mediumBodyText(
                                  AppColor.primary2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      navigateTo(editContactRoute);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContact() {
    return LayoutBuilder(builder: (context, size) {
      return Container(
        height: 268,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 16,
              color: AppColor.shadow.withOpacity(0.24),
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              constraints: const BoxConstraints(maxHeight: 160),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: _switchField(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 160),
                      width: 1,
                      color: AppColor.shade1,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: _buildContent(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Divider(
                thickness: 1,
                color: AppColor.shade1,
              ),
            ),
            AppButtonTheme.fillRounded(
              color: AppColor.transparent,
              highlightColor: AppColor.shade1,
              constraints: const BoxConstraints(minHeight: 44),
              borderRadius: BorderRadius.circular(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgIcon(
                    SvgIcons.logout,
                    color: AppColor.text7,
                    size: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'Đăng xuất',
                      style: AppTextTheme.normalText(AppColor.text7),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return JTConfirmDialog(
                      headerTitle: 'Cảnh báo',
                      contentText: 'Bạn có chắc chắn muốn đăng xuất?',
                      onCanceled: () {
                        Navigator.of(context).pop();
                      },
                      onComfirmed: () {
                        AuthenticationBlocController()
                            .authenticationBloc
                            .add(UserLogOut());
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _switchField() {
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppButtonTheme.fillRounded(
            color: _isUserContact ? AppColor.primary2 : AppColor.white,
            highlightColor: AppColor.shade1,
            constraints: const BoxConstraints(minHeight: 38, maxWidth: 200),
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Text(
                'Khách hàng',
                style: AppTextTheme.mediumBodyText(
                  _isUserContact ? AppColor.white : AppColor.text3,
                ),
              ),
            ),
            onPressed: () {
              setState(() {
                _isUserContact = true;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AppButtonTheme.fillRounded(
              color: !_isUserContact ? AppColor.primary2 : AppColor.white,
              highlightColor: AppColor.shade1,
              constraints: const BoxConstraints(minHeight: 38, maxWidth: 200),
              borderRadius: BorderRadius.circular(10),
              child: Center(
                child: Text(
                  'Người giúp việc',
                  style: AppTextTheme.mediumBodyText(
                    !_isUserContact ? AppColor.white : AppColor.text3,
                  ),
                ),
              ),
              onPressed: () {
                setState(() {
                  _isUserContact = false;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    final contacts = _isUserContact
        ? widget.listContactInfo[0].contacts
        : widget.listContactInfo[1].contacts;
    return LayoutBuilder(builder: (context, size) {
      final screenSize = MediaQuery.of(context).size;
      final itemWidth = size.maxWidth - 16;
      return Container(
        constraints: BoxConstraints(maxHeight: screenSize.height / 5 * 3),
        width: itemWidth,
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: _scrollController.hasClients,
          child: ListView(
            controller: _scrollController,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: _profileType(
                  title: 'Kênh liên lạc',
                  children: [
                    for (var item in contacts)
                      _profileItem(
                        width: itemWidth / 2,
                        title: item.name,
                        description: item.description,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _profileType({
    required String title,
    required List<Widget> children,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              title,
              style: AppTextTheme.normalHeaderTitle(AppColor.shadow),
            ),
          ),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: children,
          ),
        ],
      ),
    );
  }

  Widget _profileItem({
    required String title,
    required String description,
    required double width,
  }) {
    return Container(
      width: width,
      constraints: const BoxConstraints(minHeight: 18),
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Text(
              '$title:',
              style: AppTextTheme.normalText(AppColor.text8),
            ),
          ),
          Text(
            description,
            style: AppTextTheme.normalText(AppColor.text3),
          ),
        ],
      ),
    );
  }
}
