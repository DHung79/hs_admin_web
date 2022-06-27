import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../main.dart';
import '../../../widgets/display_date_time.dart';
import '../../../widgets/joytech_components/joytech_components.dart';
import '/core/notification/push_noti.dart';
import '../../../theme/app_theme.dart';

class PushNotiOverView extends StatefulWidget {
  final PushNotiModel pushNoti;
  final PushNotiBloc pushNotiBloc;
  final Function() onFetch;
  const PushNotiOverView({
    Key? key,
    required this.pushNoti,
    required this.pushNotiBloc,
    required this.onFetch,
  }) : super(key: key);

  @override
  State<PushNotiOverView> createState() => _PushNotiOverViewState();
}

class _PushNotiOverViewState extends State<PushNotiOverView> {
  String _errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      contentPadding: EdgeInsets.zero,
      content: Container(
        width: 1020,
        constraints: const BoxConstraints(minHeight: 200),
        child: LayoutBuilder(builder: (context, size) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(26, 20, 16, 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Xem chi tiết thông báo đẩy',
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
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Text(
                    _errorMessage,
                    style: AppTextTheme.normalText(AppColor.others1),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: _notiTarget(),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Container(
                          width: 1,
                          color: AppColor.shade1,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 16, 16),
                          child: _notiDetail(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _notiTarget() {
    final createdTime = formatFromInt(
      value: widget.pushNoti.createdTime,
      context: context,
      displayedFormat: 'dd/MM/yyyy',
    );
    final updatedTime = formatFromInt(
      value: widget.pushNoti.updatedTime,
      context: context,
      displayedFormat: 'dd/MM/yyyy',
    );
    return Column(
      children: [
        _detailItem(
          width: 200,
          title: 'Loại',
          description: widget.pushNoti.targetType,
        ),
        _detailItem(
          width: 200,
          title: 'Ngày tạo',
          description: createdTime,
        ),
        _detailItem(
          width: 200,
          title: 'Chỉnh sửa lần cuối',
          description: updatedTime,
        ),
      ],
    );
  }

  Widget _notiDetail() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Tên thông báo',
                  style: AppTextTheme.normalHeaderTitle(AppColor.shadow),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Text(
                    widget.pushNoti.title,
                    style: AppTextTheme.mediumHeaderTitle(AppColor.text3),
                  ),
                ),
              ],
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
                      SvgIcons.editOutline,
                      color: AppColor.shade5,
                      size: 24,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Text(
                        'Chỉnh sửa',
                        style: AppTextTheme.mediumBodyText(AppColor.shade5),
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).pop();
                navigateTo(editPushNotiRoute + '/' + widget.pushNoti.id);
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Nội dung',
                style: AppTextTheme.normalHeaderTitle(AppColor.shadow),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  widget.pushNoti.description,
                  style: AppTextTheme.mediumHeaderTitle(AppColor.text3),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 110),
              child: InkWell(
                hoverColor: AppColor.transparent,
                splashColor: AppColor.transparent,
                highlightColor: AppColor.transparent,
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
                  _confirmDelete();
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _detailItem({
    required String title,
    required String description,
    required double width,
  }) {
    return Container(
      width: width,
      constraints: const BoxConstraints(minHeight: 18),
      child: Wrap(
        alignment: WrapAlignment.spaceBetween,
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 100),
            child: Text(
              title,
              style: AppTextTheme.mediumBodyText(AppColor.shadow),
            ),
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                description,
                style: AppTextTheme.mediumBodyText(
                  AppColor.text3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _confirmDelete() {
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
                _deleteObjectById();
              }
              if (event.logicalKey == LogicalKeyboardKey.escape) {
                Navigator.of(context).pop();
              }
            });
          },
          child: JTConfirmDialog(
            headerTitle: 'Cảnh báo',
            headerColor: AppColor.primary2,
            contentText: 'Bạn có muốn xóa thông báo đẩy này?',
            onCanceled: () {
              Navigator.of(context).pop();
            },
            comfirmButtonColor: AppColor.primary2,
            comfirmContentColor: AppColor.white,
            onComfirmed: () {
              Navigator.of(context).pop();
              _deleteObjectById();
            },
          ),
        );
      },
    );
  }

  _deleteObjectById() {
    widget.pushNotiBloc
        .deleteObject(id: widget.pushNoti.id)
        .then((model) async {
      await Future.delayed(const Duration(milliseconds: 400));
      Navigator.of(context).pop();
      widget.onFetch();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(ScreenUtil.t(I18nKey.deleted)!)),
      );
    }).catchError((e, stacktrace) async {
      await Future.delayed(const Duration(milliseconds: 400));
      logDebug(e.toString());
      setState(() {
        _errorMessage = ScreenUtil.t(I18nKey.errorWhileDelete)!;
      });
    });
  }
}
