import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/user/user.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/joytech_components/joytech_components.dart';

class UserInfoContent extends StatefulWidget {
  final String route;
  final String userId;
  final Function(int, {int? limit}) onFetch;

  const UserInfoContent({
    Key? key,
    required this.route,
    required this.userId,
    required this.onFetch,
  }) : super(key: key);

  @override
  State<UserInfoContent> createState() => _UserInfoContentState();
}

class _UserInfoContentState extends State<UserInfoContent> {
  final _scrollController = ScrollController();
  final _userBloc = UserBloc();

  @override
  void initState() {
    if (widget.userId.isNotEmpty) {
      _userBloc.fetchDataById(widget.userId);
    }
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return StreamBuilder(
      stream: _userBloc.userData,
      builder: (context, AsyncSnapshot<ApiResponse<UserModel?>> snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!.model!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildProfile(user),
              _deleteButton(),
            ],
          );
        } else {
          if (snapshot.hasError) {
            logDebug(snapshot.error.toString());
            return ErrorMessageText(
              message:
                  ScreenUtil.t(I18nKey.userNotFound)! + ': ${widget.userId}',
            );
          }
          return const JTIndicator();
        }
      },
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
              widget.onFetch(1);
              navigateTo(userManagementRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông tin người dùng',
                style: AppTextTheme.mediumBigText(AppColor.text3),
              ),
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
                          style: AppTextTheme.mediumBodyText(AppColor.primary2),
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  navigateTo(editUserRoute + '/' + widget.userId);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfile(UserModel user) {
    final screenSize = MediaQuery.of(context).size;
    return LayoutBuilder(builder: (context, size) {
      return Container(
        height: screenSize.height - 192 - 76 - 16,
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _avatarField(user),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
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
                    color: AppColor.text5,
                    size: 24,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Nhắn tin',
                    style: AppTextTheme.mediumBodyText(
                      AppColor.text5,
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

  Widget _deleteButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: AppButtonTheme.fillRounded(
            color: AppColor.transparent,
            highlightColor: AppColor.shade1,
            constraints: const BoxConstraints(minHeight: 44),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              children: [
                SvgIcon(
                  SvgIcons.delete,
                  color: AppColor.text8,
                  size: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Xóa người dùng',
                    style: AppTextTheme.mediumBodyText(AppColor.text8),
                  ),
                ),
              ],
            ),
            onPressed: () {
              _confirmDelete(id: widget.userId);
            },
          ),
        ),
      ],
    );
  }

  _confirmDelete({
    required String id,
  }) {
    final _focusNode = FocusNode();
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        FocusScope.of(context).requestFocus(_focusNode);
        return RawKeyboardListener(
          focusNode: _focusNode,
          onKey: (RawKeyEvent event) {
            setState(() {
              if (event.logicalKey == LogicalKeyboardKey.enter) {
                Navigator.of(context).pop();
                _deleteObjectById(id: id);
              }
              if (event.logicalKey == LogicalKeyboardKey.escape) {
                Navigator.of(context).pop();
              }
            });
          },
          child: JTConfirmDialog(
            headerTitle: 'Cảnh báo',
            contentText: 'Bạn có muốn xóa người dùng này?',
            onCanceled: () {
              Navigator.of(context).pop();
            },
            onComfirmed: () {
              Navigator.of(context).pop();
              _deleteObjectById(id: id);
            },
          ),
        );
      },
    );
  }

  _deleteObjectById({
    required String id,
  }) {
    _userBloc.deleteObject(id: id).then((model) async {
      await Future.delayed(const Duration(milliseconds: 400));
      widget.onFetch(1);
      navigateTo(userManagementRoute);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(ScreenUtil.t(I18nKey.deleted)! + ' ${model.email}.')),
      );
    }).catchError((e, stacktrace) async {
      await Future.delayed(const Duration(milliseconds: 400));
      logDebug(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(ScreenUtil.t(I18nKey.errorWhileDelete)!),
        ),
      );
    });
  }
}
