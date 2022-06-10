import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hs_admin_web/routes/route_names.dart';
import 'package:hs_admin_web/screens/tasker_management_screen/components/tasker_rating_dialog.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/tasker/tasker.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/joytech_components/error_message_text.dart';
import '../../../widgets/joytech_components/joytech_components.dart';

class TaskerInfoContent extends StatefulWidget {
  final String route;
  final String taskerId;
  final Function(int, {int? limit}) onFetch;

  const TaskerInfoContent({
    Key? key,
    required this.route,
    required this.taskerId,
    required this.onFetch,
  }) : super(key: key);

  @override
  State<TaskerInfoContent> createState() => _TaskerInfoContentState();
}

class _TaskerInfoContentState extends State<TaskerInfoContent> {
  final _scrollController = ScrollController();
  final _taskerBloc = TaskerBloc();

  @override
  void initState() {
    if (widget.taskerId.isNotEmpty) {
      _taskerBloc.fetchDataById(widget.taskerId);
    }
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _taskerBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return StreamBuilder(
      stream: _taskerBloc.taskerData,
      builder: (context, AsyncSnapshot<ApiResponse<TaskerModel?>> snapshot) {
        if (snapshot.hasData) {
          final tasker = snapshot.data!.model!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildProfile(tasker),
              _deleteButton(),
            ],
          );
        } else {
          if (snapshot.hasError) {
            logDebug(snapshot.error.toString());
            return ErrorMessageText(
              message: 'Không tìm thấy người giúp việc: ${widget.taskerId}',
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
              navigateTo(taskerManagementRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông tin người giúp việc',
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
                  navigateTo(editTaskerRoute + '/' + widget.taskerId);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfile(TaskerModel tasker) {
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
              child: _avatarField(tasker),
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
              child: _taskerDetail(tasker),
            ),
          ],
        ),
      );
    });
  }

  Widget _avatarField(TaskerModel tasker) {
    double rateNumber = 3.5;
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              tasker.name,
              style: AppTextTheme.mediumBodyText(AppColor.text3),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ID: 300451841',
                style: AppTextTheme.normalText(
                  AppColor.text8,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: SvgIcon(
                  SvgIcons.contentPasteBlack,
                  color: AppColor.text8,
                  size: 24,
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  allowHalfRating: true,
                  initialRating: 4.5,
                  minRating: 1,
                  itemCount: 5,
                  itemSize: 24,
                  direction: Axis.horizontal,
                  unratedColor: AppColor.primary2,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 3),
                  itemBuilder: (context, index) {
                    return SvgIcon(
                      rateNumber.floor() == index
                          ? SvgIcons.starHalf
                          : rateNumber.floor() > index
                              ? SvgIcons.star
                              : SvgIcons.starOutline,
                      color: AppColor.primary2,
                    );
                  },
                  onRatingUpdate: (value) {},
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    rateNumber.toString(),
                    style: AppTextTheme.normalHeaderTitle(AppColor.black),
                  ),
                ),
              ],
            ),
          ),
          Text(
            '(643 đánh giá)',
            style: AppTextTheme.normalHeaderTitle(
              AppColor.text3,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AppButtonTheme.fillRounded(
              color: AppColor.transparent,
              highlightColor: AppColor.shade1,
              constraints: const BoxConstraints(minHeight: 44),
              borderRadius: BorderRadius.circular(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgIcon(
                    SvgIcons.starOutline,
                    color: AppColor.text8,
                    size: 24,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      'Chi tiết đánh giá',
                      style: AppTextTheme.normalText(
                        AppColor.text8,
                      ),
                    ),
                  ),
                ],
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return TaskerRatingDialog(tasker: tasker,);
                    });
              },
            ),
          ),
          AppButtonTheme.fillRounded(
            color: AppColor.transparent,
            highlightColor: AppColor.shade1,
            constraints: const BoxConstraints(minHeight: 44),
            borderRadius: BorderRadius.circular(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgIcon(
                  SvgIcons.commentAlt,
                  color: AppColor.shade5,
                  size: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Nhắn tin',
                    style: AppTextTheme.mediumBodyText(
                      AppColor.shade5,
                    ),
                  ),
                )
              ],
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _taskerDetail(TaskerModel tasker) {
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
                  title: 'Thông tin cá nhân',
                  children: [
                    _profileItem(
                      width: itemWidth / 2,
                      title: 'Số điện thoại:',
                      description: tasker.phoneNumber,
                    ),
                    _profileItem(
                      width: itemWidth / 2,
                      title: 'Email:',
                      description: tasker.email,
                    ),
                    _profileItem(
                      width: itemWidth / 2,
                      title: 'Địa chỉ:',
                      description: tasker.address,
                    ),
                    _profileItem(
                      width: itemWidth / 2,
                      title: 'CMND:',
                      description: tasker.address,
                    ),
                    _profileItem(
                      width: itemWidth / 2,
                      title: 'Ngày cấp:',
                      description: tasker.address,
                    ),
                    _profileItem(
                      width: itemWidth / 2,
                      title: 'Nơi cấp:',
                      description: tasker.address,
                    ),
                    _profileItem(
                      width: itemWidth / 2,
                      title: 'Trình độ học vấn:',
                      description: tasker.address,
                    ),
                    _profileItem(
                      width: itemWidth / 2,
                      title: 'Trình độ tiếng anh:',
                      description: tasker.address,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
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
                    description: tasker.phoneNumber,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Tổng số tiền:',
                    description: tasker.address,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Hình thức thành toán:',
                    description: tasker.email,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Số thẻ:',
                    description: tasker.email,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
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
                    title: 'Công việc đã nhận:',
                    description: tasker.phoneNumber,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Thành công:',
                    description: tasker.address,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Thất bại:',
                    description: tasker.email,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Tỉ lệ:',
                    description: tasker.email,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  thickness: 1,
                  color: AppColor.shade1,
                ),
              ),
              _profileType(
                title: 'Thông tin pháp lý',
                children: [
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Tiền án:',
                    description: tasker.phoneNumber,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Giấy xác thực:',
                    description: 'Xem chi tiết',
                    onTap: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  thickness: 1,
                  color: AppColor.shade1,
                ),
              ),
              _profileType(
                title: 'Thông tin định danh',
                children: [
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'ID:',
                    description: tasker.phoneNumber,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Hộ khẩu:',
                    description: 'Xem chi tiết',
                    onTap: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
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
                    description: tasker.phoneNumber,
                  ),
                  _profileItem(
                    width: itemWidth / 2,
                    title: 'Cập nhật lần cuối:',
                    description: tasker.address,
                  ),
                  _profileItem(
                    width: itemWidth,
                    title: 'Người cập nhật:',
                    description: tasker.email,
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
      constraints: const BoxConstraints(minHeight: 54),
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
    Function()? onTap,
  }) {
    return Container(
      width: width,
      constraints: const BoxConstraints(minHeight: 18),
      child: Wrap(
        children: [
          Text(
            title,
            style: AppTextTheme.normalText(AppColor.text8),
          ),
          InkWell(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                description,
                style: AppTextTheme.normalText(
                  onTap != null ? AppColor.shade5 : AppColor.text3,
                ),
              ),
            ),
            onTap: onTap,
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
                    'Xóa người giúp việc',
                    style: AppTextTheme.mediumBodyText(AppColor.text8),
                  ),
                ),
              ],
            ),
            onPressed: () {
              _confirmDelete(id: widget.taskerId);
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
            contentText: 'Bạn có muốn xóa người giúp việc này?',
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
    _taskerBloc.deleteObject(id: id).then((model) async {
      await Future.delayed(const Duration(milliseconds: 400));
      widget.onFetch(1);
      navigateTo(taskerManagementRoute);
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
