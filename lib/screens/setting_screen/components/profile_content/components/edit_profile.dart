import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/admin/admin.dart';
import '../../../../../core/authentication/auth.dart';
import '../../../../../core/image_picker/image_picker.dart';
import '../../../../../core/image_picker/upload_image.dart';
import '../../../../../main.dart';
import '../../../../../theme/app_theme.dart';
import '../../../../../widgets/display_image.dart';
import '../../../../../widgets/go_back_button.dart';
import '../../../../../widgets/input_widget.dart';
import '../../../../../widgets/joytech_components/joytech_components.dart';

class EditProfile extends StatefulWidget {
  final String route;
  final AdminModel account;
  const EditProfile({
    Key? key,
    required this.route,
    required this.account,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _accountBloc = AdminBloc();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  String _errorMessage = '';
  bool _isProcessing = false;
  late EditAdminModel _editModel;
  final List<UploadImage> _images = [];

  @override
  void initState() {
    _editModel = EditAdminModel.fromModel(widget.account);
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _accountBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildProfile(),
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
              _confirmDialog(
                contentText: 'Bạn có muốn hủy bỏ?',
                onComfirmed: () {
                  navigateTo(profileRoute);
                },
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 17, 10, 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Chỉnh sửa hồ sơ',
                style: AppTextTheme.mediumBigText(AppColor.text3),
              ),
              _headerActions(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfile() {
    return LayoutBuilder(builder: (context, size) {
      return Form(
        key: _formKey,
        autovalidateMode: _autovalidate,
        child: Container(
          constraints: const BoxConstraints(minHeight: 250),
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
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: _avatarField(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: _buildContent(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _avatarField() {
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: _images.isNotEmpty
                ? Image.memory(
                    _images.first.imageData!,
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  )
                : widget.account.avatar.isNotEmpty
                    ? AbsorbPointer(
                        child: DisplayImage(widget.account.avatar),
                      )
                    : Image.asset(
                        "assets/images/logo.png",
                        width: 100,
                        height: 100,
                      ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Thay đổi hình ảnh',
                style: AppTextTheme.mediumBodyText(AppColor.primary2),
              ),
            ),
            onTap: _pickImage,
          ),
        ],
      ),
    );
  }

  _pickImage() async {
    MediaPicker.pickMedia(
      onCompleted: (images) => setState(() {
        _images.clear();
        _images.add(images.first);
      }),
    );
  }

  Widget _buildContent() {
    return LayoutBuilder(builder: (context, size) {
      final screenSize = MediaQuery.of(context).size;
      final itemWidth = size.maxWidth - 16;
      final elementWidth = size.maxWidth;
      return Container(
        constraints: BoxConstraints(maxHeight: screenSize.height / 5 * 3),
        width: itemWidth,
        child: Wrap(
          children: [
            _buildInput(
              width: elementWidth,
              title: 'Tên',
              hintText: 'Nhập tên người dùng',
              initialValue: _editModel.name,
              onChanged: (value) {
                setState(() {
                  if (_errorMessage.isNotEmpty) {
                    _errorMessage = '';
                  }
                });
              },
              validator: (value) {
                if (value!.isEmpty || value.trim().isEmpty) {
                  return ValidatorText.empty(
                      fieldName: ScreenUtil.t(I18nKey.name)!);
                } else if (value.trim().length > 50) {
                  return ValidatorText.moreThan(
                      fieldName: ScreenUtil.t(I18nKey.name)!, moreThan: 50);
                } else if (value.trim().length < 5) {
                  return ValidatorText.atLeast(
                    fieldName: ScreenUtil.t(I18nKey.name)!,
                    atLeast: 5,
                  );
                }
                return null;
              },
              onSaved: (value) => _editModel.name = value!.trim(),
            ),
            _buildInput(
              width: elementWidth,
              title: 'Số điện thoại ',
              hintText: 'Nhập số điện thoại',
              initialValue: _editModel.phoneNumber,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty || value.trim().isEmpty) {
                  return ValidatorText.empty(
                      fieldName: ScreenUtil.t(I18nKey.phoneNumber)!);
                }
                String pattern =
                    r'^(\+843|\+845|\+847|\+848|\+849|\+841|03|05|07|08|09|01[2|6|8|9])+([0-9]{8})$';
                RegExp regExp = RegExp(pattern);
                if (!regExp.hasMatch(value)) {
                  return ScreenUtil.t(I18nKey.invalidPhoneNumber)!;
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  if (_errorMessage.isNotEmpty) {
                    _errorMessage = '';
                  }
                });
              },
              onSaved: (value) {
                _editModel.phoneNumber = value!.trim();
              },
            ),
            _buildInput(
              width: elementWidth,
              title: 'Địa chỉ',
              hintText: 'Nhập địa chỉ',
              initialValue: _editModel.address,
              validator: (value) {
                if (value!.isEmpty || value.trim().isEmpty) {
                  return ValidatorText.empty(
                      fieldName: ScreenUtil.t(I18nKey.address)!);
                } else if (value.trim().length > 300) {
                  return ValidatorText.moreThan(
                    fieldName: ScreenUtil.t(I18nKey.address)!,
                    moreThan: 300,
                  );
                } else if (value.trim().length < 5) {
                  return ValidatorText.atLeast(
                    fieldName: ScreenUtil.t(I18nKey.address)!,
                    atLeast: 5,
                  );
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  if (_errorMessage.isNotEmpty) {
                    _errorMessage = '';
                  }
                });
              },
              onSaved: (value) => _editModel.address = value!.trim(),
            ),
            _buildDropDown<String>(
              width: elementWidth,
              title: 'Giới tính',
              defaultValue: _editModel.gender,
              dataSource: [
                {'name': 'Nam', 'value': 'male'},
                {'name': 'Nữ', 'value': 'female'},
                {'name': 'Khác', 'value': 'other'},
              ],
              onChanged: (value) {
                setState(() {
                  _editModel.gender = value!;
                });
              },
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInput({
    required double width,
    String title = '',
    String? hintText,
    String? initialValue,
    TextInputType? keyboardType,
    Function(String?)? onChanged,
    Function(String?)? onSaved,
    String? Function(String?)? validator,
    List<TextInputFormatter>? inputFormatters,
    bool obscureText = false,
    Widget? suffixIcon,
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
                  style: AppTextTheme.normalText(AppColor.shadow),
                ),
              ),
            InputWidget(
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              initialValue: initialValue,
              obscureText: obscureText,
              suffixIcon: suffixIcon,
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

  Widget _buildDropDown<T>({
    required double width,
    String title = '',
    required T defaultValue,
    required List<Map<String, dynamic>> dataSource,
    Function(T?)? onChanged,
  }) {
    final boxWidth = width > 450 ? width / 2 : width;
    return Container(
      constraints: BoxConstraints(
        maxWidth: boxWidth,
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
                  style: AppTextTheme.normalText(AppColor.shadow),
                ),
              ),
            JTDropdownButtonFormField<T>(
              width: boxWidth,
              height: 48,
              defaultValue: defaultValue,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColor.shade1,
                borderRadius: BorderRadius.circular(4),
              ),
              dataSource: dataSource,
              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }

  Widget _headerActions() {
    return Row(
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
                navigateTo(profileRoute);
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
                      style: AppTextTheme.mediumBodyText(AppColor.white),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: _isProcessing
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _editProfile();
                    } else {
                      setState(() {
                        _autovalidate = AutovalidateMode.onUserInteraction;
                      });
                    }
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

  _editProfile() async {
    setState(() {
      _isProcessing = true;
    });

    _accountBloc.editProfile(editModel: _editModel).then(
      (value) async {
        if (_images.isNotEmpty) {
          _accountBloc.uploadImage(image: _images.first.image);
          await Future.delayed(const Duration(milliseconds: 400));
        }
        navigateTo(profileRoute);
      },
    ).onError((ApiError error, stackTrace) {
      setState(() {
        _isProcessing = false;
        _errorMessage = showError(error.errorCode, context);
      });
    }).catchError(
      (error, stackTrace) {
        setState(() {
          _isProcessing = false;
          _errorMessage = error.toString();
        });
      },
    );
  }
}
