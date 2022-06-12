import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:validators/validators.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/service/service.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/input_widget.dart';
import '../../../widgets/joytech_components/joytech_components.dart';
import '../../../widgets/joytech_components/jt_dropdown.dart';

class CreateEditServiceForm extends StatefulWidget {
  final String route;
  final ServiceBloc serviceBloc;
  final ServiceModel? serviceModel;
  final Function(int, {int? limit}) onFetch;

  const CreateEditServiceForm({
    Key? key,
    required this.route,
    this.serviceModel,
    required this.serviceBloc,
    required this.onFetch,
  }) : super(key: key);

  @override
  State<CreateEditServiceForm> createState() => _CreateEditServiceFormState();
}

class _CreateEditServiceFormState extends State<CreateEditServiceForm> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  String _errorMessage = '';
  bool _processing = false;
  final _serviceBloc = ServiceBloc();
  late EditServiceModel _editModel;

  @override
  void initState() {
    _editModel = EditServiceModel.fromModel(widget.serviceModel);
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
        _buildContent(),
        if (widget.serviceModel != null) _deleteButton(),
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
                widget.serviceModel != null
                    ? 'Chỉnh sửa thông tin dịch vụ'
                    : 'Thêm dịch vụ',
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
                      widget.serviceModel != null ? 'Đồng ý' : 'Thêm',
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
                      if (widget.serviceModel != null) {
                        _editService();
                      } else {
                        _createService();
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
                    'Xóa dịch vụ',
                    style: AppTextTheme.mediumBodyText(AppColor.text8),
                  ),
                ),
              ],
            ),
            onPressed: () {
              _confirmDialog(
                contentText: 'Bạn có muốn xóa dịch vụ này?',
                onComfirmed: () {
                  _deleteObjectById(id: _editModel.id);
                },
              );
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
          // _buildInput(
          //   width: elementWidth,
          //   title: 'Tên',
          //   hintText: 'Nhập tên dịch vụ',
          //   initialValue: _editModel.name,
          //   onChanged: (value) {
          //     setState(() {
          //       if (_errorMessage.isNotEmpty) {
          //         _errorMessage = '';
          //       }
          //     });
          //   },
          //   validator: (value) {
          //     if (value!.trim().isEmpty) {
          //       return ValidatorText.empty(
          //           fieldName: ScreenUtil.t(I18nKey.name)!);
          //     } else if (value.trim().length > 50) {
          //       return ValidatorText.moreThan(
          //           fieldName: ScreenUtil.t(I18nKey.name)!, moreThan: 50);
          //     } else if (value.trim().length < 5) {
          //       return ValidatorText.atLeast(
          //         fieldName: ScreenUtil.t(I18nKey.name)!,
          //         atLeast: 5,
          //       );
          //     }
          //     return null;
          //   },
          //   onSaved: (value) => _editModel.name = value!.trim(),
          // ),
          // _buildDropDown<String>(
          //   width: elementWidth,
          //   title: 'Giới tính',
          //   defaultValue: _editModel.gender,
          //   dataSource: [
          //     {'name': 'Nam', 'value': 'male'},
          //     {'name': 'Nữ', 'value': 'female'},
          //     {'name': 'Khác', 'value': 'other'},
          //   ],
          //   onChanged: (value) {
          //     setState(() {
          //       _editModel.gender = value!;
          //     });
          //   },
          // ),
          // _buildDropDown<String>(
          //   width: elementWidth,
          //   title: 'Hình thức thanh toán',
          //   defaultValue: _paymentController.text,
          //   dataSource: [
          //     {'name': 'Tài khoản ngân hàng', 'value': '1'},
          //     {'name': 'Trả sau', 'value': '2'},
          //   ],
          //   onChanged: (value) {
          //     setState(() {
          //       _paymentController.text = value!;
          //     });
          //   },
          // ),
          // if (_paymentController.text == '1')
          //   _buildInput(
          //     width: elementWidth,
          //     title: 'Tài khoản ngân hàng',
          //     hintText: 'Nhập số tài khoản',
          //     initialValue: _editModel.id,
          //     onChanged: (value) {
          //       setState(() {
          //         if (_errorMessage.isNotEmpty) {
          //           _errorMessage = '';
          //         }
          //       });
          //     },
          //     onSaved: (value) {},
          //     validator: (value) {
          //       return null;
          //     },
          //   ),
        ],
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

  _createService() async {
    setState(() {
      _processing = true;
    });
    _serviceBloc.createObject(editModel: _editModel).then(
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
          logDebug(error);
          _errorMessage = error.toString();
        });
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

  _deleteObjectById({
    required String id,
  }) {
    _serviceBloc.deleteObject(id: id).then((model) async {
      await Future.delayed(const Duration(milliseconds: 400));
      widget.onFetch(1);
      navigateTo(serviceManagementRoute);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(ScreenUtil.t(I18nKey.deleted)! + ' ${model.name}.')),
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
