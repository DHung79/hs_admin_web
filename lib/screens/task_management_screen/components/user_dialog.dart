import 'package:flutter/material.dart';
import 'package:hs_admin_web/core/user/user.dart';
import 'package:hs_admin_web/widgets/joytech_components/joytech_components.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';

class UserDialog extends StatefulWidget {
  final String userId;
  const UserDialog({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  State<UserDialog> createState() => _UserDialogState();
}

class _UserDialogState extends State<UserDialog> {
  final _scrollController = ScrollController();
  final _userBloc = UserBloc();

  @override
  void initState() {
    if (widget.userId.isNotEmpty) {
      _userBloc.fetchDataById(widget.userId);
    }
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, size) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        content: Container(
          height: screenSize.height - 150,
          width: 1020,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
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
          child: StreamBuilder(
              stream: _userBloc.userData,
              builder:
                  (context, AsyncSnapshot<ApiResponse<UserModel?>> snapshot) {
                if (snapshot.hasData) {
                  final user = snapshot.data!.model!;
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Thông tin khách hàng',
                              style: AppTextTheme.normalHeaderTitle(
                                AppColor.black,
                              ),
                            ),
                            InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SvgIcon(
                                  SvgIcons.close,
                                  color: AppColor.black,
                                  size: 24,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: _avatarField(user),
                          ),
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 32),
                              child: Container(
                                width: 1,
                                color: AppColor.shade1,
                              ),
                            ),
                          ),
                          Expanded(
                            child: _userDetail(user),
                          ),
                        ],
                      ),
                    ],
                  );
                }
                return const JTIndicator();
              }),
        ),
      );
    });
  }

  Widget _avatarField(UserModel user) {
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/images/logo.png",
              width: 100,
              height: 100,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            user.name,
            style: AppTextTheme.mediumBodyText(AppColor.text3),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgIcon(
                    SvgIcons.message,
                    color: AppColor.shade5,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Nhắn tin',
                    style: AppTextTheme.mediumBodyText(
                      AppColor.shade5,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _userDetail(UserModel user) {
    return LayoutBuilder(builder: (context, size) {
      final screenSize = MediaQuery.of(context).size;
      final itemWidth = size.maxWidth - 16;
      return SizedBox(
        height: screenSize.height - 234,
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
                  title: 'Thông tin liên lạc',
                  children: [
                    _profileItem(
                      width: itemWidth / 2,
                      title: 'Số điện thoại:',
                      description: user.phoneNumber,
                    ),
                    _profileItem(
                      width: itemWidth / 2,
                      title: 'Email:',
                      description: user.email,
                    ),
                    _profileItem(
                      width: itemWidth,
                      title: 'Địa chỉ:',
                      description: user.address,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Divider(
                  thickness: 1,
                  color: AppColor.shade1,
                ),
              ),
              _profileType(
                title: 'Thông tin thanh toán',
                children: [
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Số tiền hiện tại:',
                    description: user.phoneNumber,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Tổng số tiền:',
                    description: user.address,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Hình thức thành toán:',
                    description: user.email,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Số thẻ:',
                    description: user.email,
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Divider(
                  thickness: 1,
                  color: AppColor.shade1,
                ),
              ),
              _profileType(
                title: 'Thông tin dịch vụ',
                children: [
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Dịch vụ đã sử dụng:',
                    description: user.phoneNumber,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Thành công:',
                    description: user.address,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Thất bại:',
                    description: user.email,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Tỉ lệ:',
                    description: user.email,
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Divider(
                  thickness: 1,
                  color: AppColor.shade1,
                ),
              ),
              _profileType(
                title: 'Thông tin khác',
                children: [
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Tham gia hệ thống:',
                    description: user.phoneNumber,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Cập nhật lần cuối:',
                    description: user.address,
                  ),
                  _profileItem(
                    width: itemWidth,
                    title: 'Người cập nhật:',
                    description: user.email,
                  ),
                ],
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
              title,
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
