import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/user/user.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/joytech_components/error_message_text.dart';
import '../../../widgets/joytech_components/joytech_components.dart';

class EditUserContent extends StatefulWidget {
  final String route;
  final String? id;

  const EditUserContent({
    Key? key,
    required this.route,
    this.id,
  }) : super(key: key);

  @override
  State<EditUserContent> createState() => _EditUserContentState();
}

class _EditUserContentState extends State<EditUserContent> {
  final _userBloc = UserBloc();
  late EditUserModel _editModel;
  @override
  void initState() {
    if (widget.id != null) {
      _userBloc.fetchDataById(widget.id!);
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
    if (widget.id != null) {
      return FutureBuilder(
        future: _userBloc.fetchDataById(widget.id!),
        builder: (context, AsyncSnapshot<UserModel?> snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const JTIndicator();
          }
          if (snapshot.hasData) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(user: snapshot.data!),
                // _buildProfile(context),
                _deleteButton(user: snapshot.data!),
              ],
            );
          } else {
            if (snapshot.hasError) {
              return ErrorMessageText(message: snapshot.error.toString());
            }
            return ErrorMessageText(
              message: ScreenUtil.t(I18nKey.userNotFound)! + ': ${widget.id}',
            );
          }
        },
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          // _buildProfile(context),
          _deleteButton(),
        ],
      );
    }
  }

  Widget _buildHeader({UserModel? user}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: GoBackButton(
            onPressed: () {
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
                widget.id != null
                    ? 'Chỉnh sửa thông tin người dùng'
                    : 'Thêm người dùng',
                style: AppTextTheme.mediumBigText(AppColor.text3),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AppButtonTheme.fillRounded(
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
                      _confirmDelete(id: _editModel.id);
                    },
                  ),
                  AppButtonTheme.fillRounded(
                    constraints: const BoxConstraints(minHeight: 44),
                    color: AppColor.transparent,
                    borderRadius: BorderRadius.circular(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: AppColor.white,
                              shape: BoxShape.circle,
                            ),
                            child: SvgIcon(
                              SvgIcons.check,
                              color: AppColor.others2,
                              size: 24,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Đồng ý',
                              style: AppTextTheme.mediumBodyText(
                                  AppColor.primary2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _deleteButton({UserModel? user}) {
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
              _confirmDelete(id: _editModel.id);
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

  Padding addUser() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'THÊM NGƯỜI DÙNG',
        style: AppTextTheme.mediumBigText(AppColor.text3),
      ),
    );
  }

  Container formprofile(BuildContext context) {
    return Container(
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
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          imageUser(),
          const SizedBox(
            width: 10,
          ),
          // profileUser(),
        ],
      ),
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

  // Flexible profileUser() {
  //   return Flexible(
  //     flex: 4,
  //     child: Form(
  //         child: Row(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Flexible(
  //           flex: 1,
  //           child: Column(
  //             children: [
  //               FormUserWidget(
  //                 showTitle: true,
  //                 isWidth: false,
  //                 controller: nameController,
  //                 hintText: 'Nhập tên người dùng',
  //                 title: 'Tên',
  //               ),
  //               FormUserWidget(
  //                 showTitle: true,
  //                 isWidth: false,
  //                 controller: addressController,
  //                 hintText: 'Nhập địa chỉ',
  //                 title: 'Địa chỉ',
  //               ),
  //               const DropdownWidget(),
  //             ],
  //           ),
  //         ),
  //         Expanded(
  //           flex: 1,
  //           child: Column(
  //             children: [
  //               FormUserWidget(
  //                 showTitle: true,
  //                 isWidth: false,
  //                 controller: emailController,
  //                 hintText: 'Nhập email',
  //                 title: 'Email',
  //               ),
  //               FormUserWidget(
  //                 showTitle: true,
  //                 isWidth: false,
  //                 controller: numberPhoneController,
  //                 hintText: 'Nhập số điện thoại',
  //                 title: 'Số điện thoại',
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     )),
  //   );
  // }

  Flexible imageUser() {
    return Flexible(
      flex: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 16,
              ),
              child: InkWell(
                onTap: () {},
                child: Text(
                  'Thay đổi hình ảnh',
                  style: AppTextTheme.mediumBodyText(
                    AppColor.primary2,
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
