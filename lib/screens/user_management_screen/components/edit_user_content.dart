import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/user/user.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/input_widget.dart';
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
  EditUserModel _editModel = EditUserModel.fromModel(null);

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
            _editModel = EditUserModel.fromModel(snapshot.data);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(user: snapshot.data!),
                _buildContent(),
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
          _buildContent(),
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
              _confirmDialog(
                contentText: 'Bạn có muốn trở về?',
                onComfirmed: () {
                  navigateTo(userManagementRoute);
                },
              );
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
                          SvgIcons.close,
                          color: AppColor.text3,
                          size: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            'Hủy bỏ',
                            style: AppTextTheme.mediumBodyText(AppColor.text3),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      _confirmDialog(
                        contentText: 'Bạn có muốn hủy bỏ?',
                        onComfirmed: () {
                          navigateTo(userManagementRoute);
                        },
                      );
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: AppButtonTheme.fillRounded(
                      constraints: const BoxConstraints(minHeight: 44),
                      color: AppColor.shade9,
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: AppColor.white,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: SvgIcon(
                                  SvgIcons.check,
                                  color: AppColor.shade9,
                                  size: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Đồng ý',
                                style:
                                    AppTextTheme.mediumBodyText(AppColor.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onPressed: () {
                        
                      },
                    ),
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
              _confirmDialog(
                contentText: 'Bạn có muốn xóa người dùng này?',
                onComfirmed: () {
                  _deleteObjectById(id: widget.id!);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  _confirmDialog({
    required String contentText,
    required Function()? onComfirmed,
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
                onComfirmed!();
              }
              if (event.logicalKey == LogicalKeyboardKey.escape) {
                Navigator.of(context).pop();
              }
            });
          },
          child: JTConfirmDialog(
            headerTitle: 'Cảnh báo',
            contentText: contentText,
            onCanceled: () {
              Navigator.of(context).pop();
            },
            onComfirmed: () {
              Navigator.of(context).pop();
              onComfirmed!();
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

  Widget _buildContent() {
    return LayoutBuilder(builder: (context, size) {
      return Container(
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
        width: size.maxWidth,
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 200,
                child: _avatarField(),
              ),
              SizedBox(
                width: size.maxWidth - 232,
                child: _buildInputField(),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildInputField() {
    return LayoutBuilder(builder: (context, size) {
      final elementWidth = size.maxWidth;
      return Wrap(
        children: [
          _buildInput(
            width: elementWidth,
            title: 'Tên',
            hintText: 'Nhập tên người dùng',
            initialValue: _editModel.name,
            onChanged: (value) {},
            onSaved: (value) {},
            validator: (value) {
              return null;
            },
          ),
          _buildInput(
            width: elementWidth,
            title: 'Số điện thoại ',
            hintText: 'Nhập số điện thoại',
            initialValue: _editModel.name,
            onChanged: (value) {},
            onSaved: (value) {},
            validator: (value) {
              return null;
            },
          ),
          _buildInput(
            width: elementWidth,
            title: 'Địa chỉ',
            hintText: 'Nhập địa chỉ',
            initialValue: _editModel.name,
            onChanged: (value) {},
            onSaved: (value) {},
            validator: (value) {
              return null;
            },
          ),
        ],
      );
    });
  }

  Widget _buildInput({
    required double width,
    String title = '',
    String? hintText,
    String? initialValue,
    Function(String?)? onChanged,
    Function(String?)? onSaved,
    String? Function(String?)? validator,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: width > 450 ? width / 2 : width,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  title,
                  style: AppTextTheme.normalText(AppColor.black),
                ),
              ),
            InputWidget(
              initialValue: initialValue,
              borderColor: AppColor.text7,
              hintText: hintText,
              onSaved: onSaved,
              onChanged: onChanged,
              validator: validator,
            ),
          ],
        ),
      ),
    );
  }

  Widget _avatarField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(
            width: 100,
            height: 100,
            child: CircleAvatar(
              backgroundImage: NetworkImage('assets/images/logo.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: InkWell(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16,
                ),
                child: Text(
                  'Thay đổi hình ảnh',
                  style: AppTextTheme.mediumBodyText(
                    AppColor.primary2,
                  ),
                ),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}
