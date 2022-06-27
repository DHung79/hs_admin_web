import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/push_notification/push_noti.dart';
import '../../../../../core/authentication/auth.dart';
import '../../../../../main.dart';
import '../../../../../theme/app_theme.dart';
import '../../../../../widgets/go_back_button.dart';
import '../../../../../widgets/input_widget.dart';
import '../../../../../widgets/joytech_components/joytech_components.dart';

class CreateEditPushNoti extends StatefulWidget {
  final String route;
  final PushNotiModel? pushNoti;
  final Function(int, {int? limit}) onFetch;
  const CreateEditPushNoti({
    Key? key,
    required this.route,
    this.pushNoti,
    required this.onFetch,
  }) : super(key: key);

  @override
  State<CreateEditPushNoti> createState() => _CreateEditPushNotiState();
}

class _CreateEditPushNotiState extends State<CreateEditPushNoti> {
  final _pushNotiBloc = PushNotiBloc();
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  String _errorMessage = '';
  bool _processing = false;
  late EditPushNotiModel _editModel;
  bool _isUserNoti = true;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _editModel = EditPushNotiModel.fromModel(
      widget.pushNoti,
    );
    if (widget.pushNoti != null) {
      _nameController.text = widget.pushNoti!.title;
      _descriptionController.text = widget.pushNoti!.description;
    }
    _isUserNoti = _editModel.targetType.toLowerCase() == 'khách hàng';

    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        _buildFormField(),
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
                  navigateTo(pushNotiManagementRoute);
                  widget.onFetch(1);
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
                widget.pushNoti != null
                    ? 'Chỉnh sửa thông báo đẩy'
                    : 'Thêm thông báo đẩy',
                style: AppTextTheme.mediumBigText(AppColor.text3),
              ),
              _headerActions(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFormField() {
    return LayoutBuilder(builder: (context, size) {
      return Form(
        key: _formKey,
        autovalidateMode: _autovalidate,
        child: Container(
          constraints: const BoxConstraints(minHeight: 250),
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
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: _switchField(),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16),
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

  Widget _switchField() {
    return SizedBox(
      width: 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AppButtonTheme.fillRounded(
            color: _isUserNoti ? AppColor.primary2 : AppColor.white,
            highlightColor: AppColor.shade1,
            constraints: const BoxConstraints(minHeight: 44, maxWidth: 200),
            borderRadius: BorderRadius.circular(10),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
                    child: SvgIcon(
                      _isUserNoti
                          ? SvgIcons.radioButtonChecked
                          : SvgIcons.radioButtonUnchecked,
                      color: _isUserNoti ? AppColor.white : AppColor.text3,
                      size: 24,
                    ),
                  ),
                  Text(
                    'Khách hàng',
                    style: AppTextTheme.mediumBodyText(
                      _isUserNoti ? AppColor.white : AppColor.text3,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              setState(() {
                _isUserNoti = true;
                _editModel.targetType = 'Khách hàng';
                _nameController.clear();
                _descriptionController.clear();
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AppButtonTheme.fillRounded(
              color: !_isUserNoti ? AppColor.primary2 : AppColor.white,
              highlightColor: AppColor.shade1,
              constraints: const BoxConstraints(minHeight: 44, maxWidth: 200),
              borderRadius: BorderRadius.circular(10),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 12, 0),
                      child: SvgIcon(
                        !_isUserNoti
                            ? SvgIcons.radioButtonChecked
                            : SvgIcons.radioButtonUnchecked,
                        color: !_isUserNoti ? AppColor.white : AppColor.text3,
                        size: 24,
                      ),
                    ),
                    Text(
                      'Người giúp việc',
                      style: AppTextTheme.mediumBodyText(
                        !_isUserNoti ? AppColor.white : AppColor.text3,
                      ),
                    ),
                  ],
                ),
              ),
              onPressed: () {
                setState(() {
                  _isUserNoti = false;
                  _editModel.targetType = 'Người giúp việc';
                  _nameController.clear();
                  _descriptionController.clear();
                });
              },
            ),
          ),
        ],
      ),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildInput(
              width: elementWidth,
              title: 'Tên',
              hintText: 'Nhập tên',
              controller: _nameController,
              validator: (value) {
                if (value!.isEmpty || value.trim().isEmpty) {
                  return ValidatorText.empty(fieldName: 'Tên');
                } else if (value.trim().length > 300) {
                  return ValidatorText.moreThan(
                    fieldName: 'Tên',
                    moreThan: 300,
                  );
                } else if (value.trim().length < 5) {
                  return ValidatorText.atLeast(
                    fieldName: 'Tên',
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
              onSaved: (value) {
                _editModel.title = value!.trim();
              },
            ),
            _buildInput(
                width: elementWidth,
                title: 'Nội dung',
                hintText: 'Nhập nội dung vào đây...',
                controller: _descriptionController,
                maxLines: 8,
                validator: (value) {
                  if (value!.isEmpty || value.trim().isEmpty) {
                    return ValidatorText.empty(fieldName: 'Nội dung');
                  } else if (value.trim().length > 300) {
                    return ValidatorText.moreThan(
                      fieldName: 'Nội dung',
                      moreThan: 300,
                    );
                  } else if (value.trim().length < 5) {
                    return ValidatorText.atLeast(
                      fieldName: 'Nội dung',
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
                onSaved: (value) {
                  _editModel.description = value!.trim();
                }),
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
    TextEditingController? controller,
    int? maxLines,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: width,
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
              controller: controller,
              maxLines: maxLines,
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
                navigateTo(pushNotiManagementRoute);
                widget.onFetch(1);
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
                      widget.pushNoti != null ? 'Đồng ý' : 'Thêm',
                      style: AppTextTheme.mediumBodyText(AppColor.white),
                    ),
                  ),
                ],
              ),
            ),
            onPressed: _processing
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      if (widget.pushNoti != null) {
                        _editPushNoti();
                      } else {
                        _createPushNoti();
                      }
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

  _createPushNoti() async {
    setState(() {
      _processing = true;
    });
    _pushNotiBloc
        .createObject(
      editModel: _editModel,
    )
        .then(
      (value) async {
        navigateTo(pushNotiManagementRoute);
        widget.onFetch(1);
        await Future.delayed(const Duration(milliseconds: 400));
      },
    ).onError((ApiError error, stackTrace) {
      setState(() {
        _processing = false;
        _errorMessage = showError(error.errorCode, context);
      });
    }).catchError(
      (error, stackTrace) {
        setState(() {
          _processing = false;
          _errorMessage = error.toString();
        });
      },
    );
  }

  _editPushNoti() async {
    setState(() {
      _processing = true;
    });
    _pushNotiBloc
        .editObject(
      editModel: _editModel,
      id: _editModel.id,
    )
        .then(
      (value) async {
        navigateTo(pushNotiManagementRoute);
        widget.onFetch(1);
        await Future.delayed(const Duration(milliseconds: 400));
      },
    ).onError((ApiError error, stackTrace) {
      setState(() {
        _processing = false;
        _errorMessage = showError(error.errorCode, context);
      });
    }).catchError(
      (error, stackTrace) {
        setState(() {
          _processing = false;
          _errorMessage = error.toString();
        });
      },
    );
  }
}
