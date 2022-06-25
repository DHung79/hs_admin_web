import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/task/task.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/joytech_components/joytech_components.dart';
import 'takser_dialog.dart';
import 'task_list.dart';
import 'user_dialog.dart';

class TaskDetailContent extends StatefulWidget {
  final String route;
  final String id;
  final Function(int, {int? limit}) onFetch;

  const TaskDetailContent({
    Key? key,
    required this.route,
    required this.id,
    required this.onFetch,
  }) : super(key: key);

  @override
  State<TaskDetailContent> createState() => _TaskDetailContentState();
}

class _TaskDetailContentState extends State<TaskDetailContent> {
  final _avatarScrollController = ScrollController();
  final _contentScrollController = ScrollController();
  final _taskBloc = TaskBloc();

  @override
  void initState() {
    if (widget.id.isNotEmpty) {
      _taskBloc.fetchDataById(widget.id);
    }
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _taskBloc.dispose();
    _avatarScrollController.dispose();
    _contentScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return StreamBuilder(
      stream: _taskBloc.taskData,
      builder: (context, AsyncSnapshot<ApiResponse<TaskModel?>> snapshot) {
        if (snapshot.hasData) {
          final task = snapshot.data!.model!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildProfile(task),
              _deleteButton(task),
            ],
          );
        } else {
          if (snapshot.hasError) {
            return ErrorMessageText(
              message: 'Không tìm thấy đơn hàng: ${widget.id}',
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
              navigateTo(tasksRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông tin đơn hàng',
                style: AppTextTheme.mediumBigText(AppColor.text3),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfile(TaskModel task) {
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
            SizedBox(
              width: 200,
              child: Scrollbar(
                controller: _avatarScrollController,
                thumbVisibility: _avatarScrollController.hasClients,
                child: ListView(
                  controller: _avatarScrollController,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          _avatarField(
                            title: 'Khách hàng',
                            imageUrl: '',
                            name: task.user!.name,
                            onTap: () {
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return UserDialog(userId: task.user!.id);
                                },
                              );
                            },
                          ),
                          if (task.tasker != null && task.tasker!.id.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Divider(
                                thickness: 1,
                                color: AppColor.shade1,
                              ),
                            ),
                          if (task.tasker != null && task.tasker!.id.isNotEmpty)
                            _avatarField(
                              title: 'Người giúp việc',
                              imageUrl: '',
                              name: task.tasker!.name,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (BuildContext context) {
                                    return TaskerDialog(
                                      taskerId: task.tasker!.id,
                                    );
                                  },
                                );
                              },
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              width: 1,
              color: AppColor.shade1,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: _taskDetail(task),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _avatarField({
    required String title,
    required String imageUrl,
    required String name,
    Function()? onTap,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: AppTextTheme.mediumBodyText(AppColor.text3),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.asset(
              "assets/images/logo.png",
              width: 100,
              height: 100,
            ),
          ),
        ),
        Text(
          name,
          style: AppTextTheme.mediumBodyText(AppColor.text3),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                'Xem thêm',
                style: AppTextTheme.normalText(AppColor.shade5),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _taskDetail(TaskModel task) {
    return LayoutBuilder(builder: (context, size) {
      final screenSize = MediaQuery.of(context).size;
      final itemWidth = size.maxWidth - 16;
      return Container(
        constraints: BoxConstraints(maxHeight: screenSize.height / 5 * 3),
        width: itemWidth,
        child: Scrollbar(
          controller: _contentScrollController,
          thumbVisibility: _contentScrollController.hasClients,
          child: ListView(
            controller: _contentScrollController,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: _detailType(
                  title: 'Thông tin dịch vụ',
                  children: [
                    _detailItem(
                      width: itemWidth / 2,
                      title: 'Trạng thái:',
                      status: getStatusText(task.status),
                      description: '',
                    ),
                    _detailItem(
                      width: itemWidth / 2,
                      title: 'Dịch vụ:',
                      description: task.service!.name,
                    ),
                    _detailItem(
                      width: itemWidth / 2,
                      title: 'Tổng tiền:',
                      description: task.totalPrice.toString(),
                    ),
                    _detailItem(
                      width: itemWidth / 2,
                      title: 'Tùy chọn:',
                      description: '2 phòng',
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
              _detailType(
                title: 'Thông tin công việc',
                children: [
                  _buildJobDetail(
                    title: 'Thông tin cơ bản:',
                    details: [
                      JobDetail(
                        title: 'Địa chỉ:',
                        notes: [task.address!],
                      ),
                      JobDetail(
                        title: 'Thời gian làm:',
                        notes: [task.startTime.toString()],
                      ),
                      JobDetail(
                        title: 'Loại nhà:',
                        notes: [getHomeType(task.typeHome!)],
                      ),
                      JobDetail(
                        title: 'Tùy chọn:',
                        notes: ['2 phòng'],
                      ),
                    ],
                  ),
                  _buildJobDetail(
                    title: 'Yêu cầu từ khách hàng:',
                    details: [
                      JobDetail(
                        title: 'Ghi chú:',
                        notes: [task.note!],
                      ),
                      JobDetail(
                        title: 'Danh sách kiểm tra:',
                        notes: [
                          ' - Lau ghế rồng',
                          ' - Lau bình hoa',
                          ' - Kiểm tra thức ăn cho cún',
                        ],
                      ),
                      JobDetail(
                        title: 'Dụng cụ tự mang:',
                        notes: [
                          ' - Chổi',
                          ' - Cây lau nhà',
                        ],
                      ),
                    ],
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
              _detailType(
                title: 'Thông tin thanh toán',
                children: [
                  _detailItem(
                    width: itemWidth,
                    title: 'Hình thức 1:',
                    description: 'Momo',
                  ),
                  _detailItem(
                    width: itemWidth,
                    title: 'Hình thức 2:',
                    description: 'Tiền mặt',
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
              _detailType(
                title: 'Thông tin khác',
                children: [
                  _detailItem(
                    width: itemWidth / 2,
                    title: 'Tham gia hệ thống:',
                    description: task.createdTime.toString(),
                  ),
                  _detailItem(
                    width: itemWidth / 2,
                    title: 'Cập nhật lần cuối:',
                    description: task.updatedTime.toString(),
                  ),
                  _detailItem(
                    width: itemWidth,
                    title: 'Người cập nhật:',
                    description: task.id!,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _detailType({
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

  Widget _detailItem({
    required String title,
    Widget? status,
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
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (status != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: status,
                ),
              Text(
                description,
                style: AppTextTheme.normalText(AppColor.text3),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildJobDetail({
    required String title,
    required List<JobDetail> details,
  }) {
    const double titleWidth = 120;
    const double detailTitleWidth = 150;

    return LayoutBuilder(builder: (context, size) {
      final double itemWidth =
          size.maxWidth - titleWidth - detailTitleWidth - 58;
      return Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(
              color: AppColor.shade5,
              width: 4,
            ),
          ),
        ),
        child: _buildJobItem(
          width: titleWidth,
          title: title,
          style: AppTextTheme.normalText(AppColor.shadow),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var detail in details)
                Padding(
                  padding: EdgeInsets.only(
                      top: details.indexOf(detail) != 0 ? 16 : 0),
                  child: _buildJobItem(
                    title: detail.title,
                    width: detailTitleWidth,
                    style: AppTextTheme.normalText(AppColor.shadow),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var note in detail.notes)
                            SizedBox(
                              width: itemWidth,
                              child: Text(
                                note,
                                style: AppTextTheme.normalText(AppColor.text3),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildJobItem({
    required String title,
    required TextStyle? style,
    required Widget child,
    double? width,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16),
          child: SizedBox(
            width: width,
            child: Text(
              title,
              style: style,
            ),
          ),
        ),
        child,
      ],
    );
  }

  Widget _deleteButton(TaskModel task) {
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
                  SvgIcons.close,
                  color: AppColor.text8,
                  size: 24,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Hủy đơn hàng',
                    style: AppTextTheme.mediumBodyText(AppColor.text8),
                  ),
                ),
              ],
            ),
            onPressed: () {
              _confirmDelete(task: task);
            },
          ),
        ),
      ],
    );
  }

  _confirmDelete({
    required TaskModel task,
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
                _deleteObjectById(id: task.id!);
              }
              if (event.logicalKey == LogicalKeyboardKey.escape) {
                Navigator.of(context).pop();
              }
            });
          },
          child: JTConfirmDialog(
            headerTitle: 'Cảnh báo',
            headerColor: AppColor.primary2,
            contentText:
                'Bạn có chắc muốn hủy dịch vụ Dọn dẹp nhà theo giờ của ${task.user?.name}?',
            onCanceled: () {
              Navigator.of(context).pop();
            },
            onComfirmed: () {
              Navigator.of(context).pop();
              _deleteObjectById(id: task.id!);
            },
          ),
        );
      },
    );
  }

  _deleteObjectById({
    required String id,
  }) {
    _taskBloc.deleteObject(id: id).then((model) async {
      await Future.delayed(const Duration(milliseconds: 400));
      widget.onFetch(1);
      navigateTo(tasksRoute);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(ScreenUtil.t(I18nKey.deleted)! +
                ' đặt hàng của ${model.user?.name}.')),
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

  String getHomeType(int type) {
    switch (type) {
      case 0:
        return 'Nhà ở';
      case 1:
        return 'Căn hộ';
      case 2:
        return 'Vila';
      default:
        return '';
    }
  }
}

class JobDetail {
  final String title;
  final List<String> notes;
  JobDetail({
    required this.title,
    required this.notes,
  });
}
