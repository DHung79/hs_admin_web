import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/service/service.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/input_widget.dart';
import '../../../widgets/joytech_components/joytech_components.dart';

class EditServiceForm extends StatefulWidget {
  final String route;
  final ServiceBloc serviceBloc;
  final ServiceModel serviceModel;
  final Function(int, {int? limit}) onFetch;

  const EditServiceForm({
    Key? key,
    required this.route,
    required this.serviceModel,
    required this.serviceBloc,
    required this.onFetch,
  }) : super(key: key);

  @override
  State<EditServiceForm> createState() => _EditServiceFormState();
}

class _EditServiceFormState extends State<EditServiceForm> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  String _errorMessage = '';
  bool _processing = false;
  final _serviceBloc = ServiceBloc();
  late EditServiceModel _editModel;

  @override
  void initState() {
    _editModel = EditServiceModel.fromModel(widget.serviceModel);
    if (_editModel.options.length < 2) {
      for (int i = 0; i <= 2 - _editModel.options.length; i++) {
        _editModel.options.add(OptionsModel.fromJson({}));
      }
    }
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
        _renderError(),
        Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: _buildContent(),
        ),
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
                contentText: 'Bạn có muốn trở về?',
                onComfirmed: () {
                  widget.onFetch(1);
                  navigateTo(serviceManagementRoute);
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
                'Chỉnh sửa dịch vụ',
                style: AppTextTheme.mediumBigText(AppColor.text3),
              ),
              _headerActions(),
            ],
          ),
        ),
      ],
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
                widget.onFetch(1);
                navigateTo(serviceManagementRoute);
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
            onPressed: _processing
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _editService();
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
          key: _formKey,
          autovalidateMode: _autovalidate,
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
            hintText: 'Nhập tên dịch vụ',
            initialValue: _editModel.name,
            onChanged: (value) {
              setState(() {
                if (_errorMessage.isNotEmpty) {
                  _errorMessage = '';
                }
              });
            },
            validator: (value) {
              if (value!.trim().isEmpty) {
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
          _buildDropDown<int>(
            width: elementWidth,
            title: 'Loại',
            defaultValue: _editModel.quantityType,
            dataSource: [
              {'name': 'Giờ', 'value': 0},
              {'name': 'Phòng', 'value': 1},
              {'name': 'Khác', 'value': 2},
            ],
            onChanged: (value) {
              setState(() {
                _editModel.quantityType = value!;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Lựa chọn',
                  style: AppTextTheme.mediumBodyText(AppColor.shadow),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        SvgIcon(
                          SvgIcons.add,
                          color: AppColor.primary2,
                          size: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Text(
                            'Thêm',
                            style:
                                AppTextTheme.mediumBodyText(AppColor.primary2),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _editModel.options.add(OptionsModel.fromJson({}));
                    });
                  },
                ),
              ],
            ),
          ),
          for (var option in _editModel.options)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 24),
              child: _buildOption(
                option: option,
                width: elementWidth,
              ),
            ),
          if (_editModel.payments.isNotEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      'Hình thức thanh toán',
                      style: AppTextTheme.mediumBodyText(AppColor.shadow),
                    ),
                  ),
                  Row(
                    children: [
                      for (var payment in _editModel.payments)
                        _buildCheckBox(
                          title: payment.name,
                          onChanged: (value) {
                            setState(() {
                              payment.isActive = value!;
                            });
                          },
                          isCheck: payment.isActive,
                        ),
                    ],
                  ),
                ],
              ),
            ),
        ],
      );
    });
  }

  Widget _buildCheckBox({
    required bool isCheck,
    Function(bool?)? onChanged,
    required String title,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColor.shade1,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 2),
                child: SizedBox(
                  height: 18,
                  width: 18,
                  child: Checkbox(
                    splashRadius: 0,
                    activeColor: AppColor.shade9,
                    checkColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    side: BorderSide(
                      color: AppColor.text7,
                      width: 2,
                    ),
                    value: isCheck,
                    onChanged: onChanged,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(11),
                child: Text(
                  title,
                  style: AppTextTheme.mediumBodyText(AppColor.text3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
    EdgeInsetsGeometry contentPadding = const EdgeInsets.all(16),
    TextEditingController? controller,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: width,
      ),
      child: Padding(
        padding: contentPadding,
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
    return Padding(
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
            width: width,
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
    );
  }

  Widget _buildOption({
    required OptionsModel option,
    required double width,
  }) {
    final index = _editModel.options.indexOf(option) + 1;
    final elementWidth = width / 2 - 2 - 32;
    final nameController = TextEditingController(text: option.name);
    nameController.selection =
        TextSelection.collapsed(offset: option.name.length);
    final noteController = TextEditingController(text: option.note);
    noteController.selection =
        TextSelection.collapsed(offset: option.note.length);
    final priceController = TextEditingController(text: '${option.price}');
    priceController.selection =
        TextSelection.collapsed(offset: '${option.price}'.length);
    final quantityController =
        TextEditingController(text: '${option.quantity}');
    quantityController.selection =
        TextSelection.collapsed(offset: '${option.quantity}'.length);

    return Container(
      width: width,
      decoration: BoxDecoration(
          border: Border(
        left: BorderSide(
          width: 4,
          color: AppColor.text7,
        ),
      )),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'Lựa chọn $index',
                    style: AppTextTheme.mediumHeaderTitle(AppColor.black),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        SvgIcon(
                          SvgIcons.delete,
                          color: AppColor.text7,
                          size: 24,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Text(
                            'Xóa',
                            style: AppTextTheme.mediumBodyText(AppColor.text7),
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    setState(() {
                      _editModel.options.remove(option);
                    });
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              runSpacing: 16,
              spacing: 16,
              children: [
                _buildInput(
                  width: elementWidth,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Nhập tên dịch vụ',
                  controller: nameController,
                  onChanged: (value) {
                    setState(() {
                      option.name = value!.trim();

                      if (_errorMessage.isNotEmpty) {
                        _errorMessage = '';
                      }
                    });
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
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
                  onSaved: (value) => option.name = value!.trim(),
                ),
                _buildInput(
                  width: elementWidth,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Nhập tên dịch vụ',
                  controller: noteController,
                  onChanged: (value) {
                    setState(() {
                      option.note = value!.trim();

                      if (_errorMessage.isNotEmpty) {
                        _errorMessage = '';
                      }
                    });
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return ValidatorText.empty(
                          fieldName: ScreenUtil.t(I18nKey.note)!);
                    } else if (value.trim().length > 50) {
                      return ValidatorText.moreThan(
                          fieldName: ScreenUtil.t(I18nKey.note)!, moreThan: 50);
                    } else if (value.trim().length < 5) {
                      return ValidatorText.atLeast(
                        fieldName: ScreenUtil.t(I18nKey.note)!,
                        atLeast: 5,
                      );
                    }
                    return null;
                  },
                  onSaved: (value) => option.note = value!.trim(),
                ),
                _buildInput(
                  width: elementWidth,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Nhập tên dịch vụ',
                  controller: priceController,
                  onChanged: (value) {
                    setState(() {
                      option.price = int.tryParse(value!.trim())!;

                      if (_errorMessage.isNotEmpty) {
                        _errorMessage = '';
                      }
                    });
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return ValidatorText.empty(fieldName: 'Giá');
                    } else if (value.trim().length > 50) {
                      return ValidatorText.moreThan(
                        fieldName: 'Giá',
                        moreThan: 50,
                      );
                    }
                    return null;
                  },
                  onSaved: (value) =>
                      option.price = int.tryParse(value!.trim())!,
                ),
                _buildInput(
                  width: elementWidth,
                  contentPadding: EdgeInsets.zero,
                  hintText: 'Nhập tên dịch vụ',
                  controller: quantityController,
                  onChanged: (value) {
                    setState(() {
                      option.quantity = int.tryParse(value!.trim())!;

                      if (_errorMessage.isNotEmpty) {
                        _errorMessage = '';
                      }
                    });
                  },
                  validator: (value) {
                    if (value!.trim().isEmpty) {
                      return ValidatorText.empty(fieldName: 'Giá');
                    } else if (value.trim().length > 50) {
                      return ValidatorText.moreThan(
                        fieldName: 'Giá',
                        moreThan: 50,
                      );
                    }
                    return null;
                  },
                  onSaved: (value) =>
                      option.quantity = int.tryParse(value!.trim())!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _avatarField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/images/logo.png",
              width: 100,
              height: 100,
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

  Widget _renderError() {
    if (_errorMessage.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          decoration: BoxDecoration(
            color: AppColor.white,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
              color: Theme.of(context).errorColor,
              width: 1,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              _errorMessage,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  fontStyle: FontStyle.italic,
                  color: Theme.of(context).errorColor),
            ),
          ),
        ),
      );
    }
    return const SizedBox();
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

  _editService() async {
    setState(() {
      _processing = true;
    });

    _serviceBloc.editObject(editModel: _editModel, id: _editModel.id).then(
      (value) async {
        widget.onFetch(1);
        navigateTo(serviceManagementRoute);
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
