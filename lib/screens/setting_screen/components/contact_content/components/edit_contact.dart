import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../core/authentication/auth.dart';
import '../../../../../core/contact/contact.dart';
import '../../../../../main.dart';
import '../../../../../theme/app_theme.dart';
import '../../../../../widgets/go_back_button.dart';
import '../../../../../widgets/input_widget.dart';
import '../../../../../widgets/joytech_components/joytech_components.dart';

class EditContact extends StatefulWidget {
  final String route;
  final ContactInfoModel contactInfo;
  final ContactBloc contactBloc;
  const EditContact({
    Key? key,
    required this.route,
    required this.contactInfo,
    required this.contactBloc,
  }) : super(key: key);

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidate = AutovalidateMode.disabled;
  String _errorMessage = '';
  bool _processing = false;
  late EditContactInfoModel _editModel;
  bool _isUserContact = true;
  int _currentTag = 0;

  @override
  void initState() {
    _editModel = EditContactInfoModel.fromModel(
      widget.contactInfo,
    );
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
              _confirmDialog(
                contentText: 'Bạn có muốn hủy bỏ?',
                onComfirmed: () {
                  navigateTo(contactRoute);
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
                'Chỉnh sửa thông tin liên lạc',
                style: AppTextTheme.mediumBigText(AppColor.text3),
              ),
              _headerActions(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContact() {
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
                _currentTag = 0;
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
                  _currentTag = 0;
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

      final contacts =
          _isUserContact ? _editModel.contactsUser : _editModel.contactsTasker;
      return Container(
        constraints: BoxConstraints(maxHeight: screenSize.height / 5 * 3),
        width: itemWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: elementWidth,
              height: 82,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: elementWidth - 192),
                    child: ListView.builder(
                        physics: const ClampingScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: contacts.length,
                        itemBuilder: (context, index) {
                          final isSelected = _currentTag == index;
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 16,
                                    color: AppColor.shadow.withOpacity(0.16),
                                    blurStyle: BlurStyle.outer,
                                  ),
                                ],
                              ),
                              child: AppButtonTheme.fillRounded(
                                color: isSelected
                                    ? AppColor.primary2
                                    : AppColor.white,
                                highlightColor: AppColor.shade1,
                                constraints: const BoxConstraints(
                                    maxHeight: 50, maxWidth: 50),
                                borderRadius: BorderRadius.circular(10),
                                child: Center(
                                  child: Text(
                                    (index + 1).toString(),
                                    style: AppTextTheme.mediumBodyText(
                                      isSelected
                                          ? AppColor.white
                                          : AppColor.text3,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    _currentTag = index;
                                  });
                                },
                              ),
                            ),
                          );
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AppButtonTheme.outlineRounded(
                            outlineColor: AppColor.text7,
                            constraints: const BoxConstraints(
                                maxHeight: 50, maxWidth: 50),
                            borderRadius: BorderRadius.circular(10),
                            child: Center(
                              child: SvgIcon(
                                SvgIcons.add,
                                size: 24,
                                color: AppColor.text7,
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                contacts.add(EditContactModel.fromModel(null));
                                _currentTag = contacts.length - 1;
                              });
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: AppButtonTheme.outlineRounded(
                            outlineColor: AppColor.white,
                            constraints: const BoxConstraints(
                              maxHeight: 50,
                            ),
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
                                    'Xóa',
                                    style: AppTextTheme.mediumBodyText(
                                        AppColor.text8),
                                  ),
                                ),
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                if (contacts.length > 1) {
                                  contacts.removeAt(_currentTag);
                                  if (_currentTag > contacts.length - 1) {
                                    _currentTag = _currentTag - 1;
                                  }
                                }
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            _buildInputField(
              elementWidth: elementWidth,
              editModel: contacts[_currentTag],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildInputField({
    required double elementWidth,
    required EditContactModel editModel,
  }) {
    return Column(
      children: [
        _buildInput(
          width: elementWidth,
          title: 'Tên',
          hintText: 'Nhập tên',
          controller: editModel.nameController,
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
              editModel.nameController.selection = TextSelection.collapsed(
                offset: editModel.nameController.selection.base.offset,
              );
              editModel.name = value!.trim();
              if (_errorMessage.isNotEmpty) {
                _errorMessage = '';
              }
            });
          },
          onSaved: (value) {
            editModel.name = value!.trim();
          },
        ),
        _buildInput(
            width: elementWidth,
            title: 'Chú thích',
            hintText: 'Nhập chú thích',
            controller: editModel.descriptionController,
            validator: (value) {
              if (value!.isEmpty || value.trim().isEmpty) {
                return ValidatorText.empty(fieldName: 'Chú thích');
              } else if (value.trim().length > 300) {
                return ValidatorText.moreThan(
                  fieldName: 'Chú thích',
                  moreThan: 300,
                );
              } else if (value.trim().length < 5) {
                return ValidatorText.atLeast(
                  fieldName: 'Chú thích',
                  atLeast: 5,
                );
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                editModel.descriptionController.selection =
                    TextSelection.collapsed(
                  offset: editModel.descriptionController.selection.base.offset,
                );
                editModel.description = value!.trim();
                if (_errorMessage.isNotEmpty) {
                  _errorMessage = '';
                }
              });
            },
            onSaved: (value) {
              editModel.description = value!.trim();
            }),
      ],
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
    TextEditingController? controller,
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
            onPressed: _processing
                ? null
                : () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _editContacts();
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

  _editContacts() async {
    setState(() {
      _processing = true;
    });
    widget.contactBloc
        .editObject(editModel: _editModel, id: _editModel.id)
        .then(
      (value) async {
        navigateTo(contactRoute);
        widget.contactBloc.fetchAllData({});

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
