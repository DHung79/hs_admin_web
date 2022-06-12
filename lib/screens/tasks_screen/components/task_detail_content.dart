import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/task/task.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/joytech_components/error_message_text.dart';
import '../../../widgets/joytech_components/joytech_components.dart';

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
  final _scrollController = ScrollController();
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
              _deleteButton(),
            ],
          );
        } else {
          if (snapshot.hasError) {
            logDebug(snapshot.error.toString());
            return ErrorMessageText(
              message: 'Không tìm thấy đặt hàng: ${widget.id}',
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
                'Thông tin đặt hàng',
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
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: _avatarField(task),
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
              child: _taskDetail(task),
            ),
          ],
        ),
      );
    });
  }

  Widget _avatarField(TaskModel task) {
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
          const SizedBox(
            height: 10,
          ),
          Text(
            task.address!,
            style: AppTextTheme.mediumBodyText(AppColor.text3),
          ),
        ],
      ),
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
          controller: _scrollController,
          thumbVisibility: _scrollController.hasClients,
          child: ListView(
            controller: _scrollController,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: _detailType(
                  title: 'Thông tin chi tiết',
                  children: [
                    _detailItem(
                      width: itemWidth,
                      title: 'Loại đặt hàng:',
                      description: task.address!,
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
                title: 'Giá',
                children: [
                  _detailItem(
                    width: itemWidth / 4,
                    title: 'Tên:',
                    description: task.tasker!.name,
                  ),
                  _detailItem(
                    width: itemWidth / 2,
                    title: 'Giá thành:',
                    description: task.user!.name,
                  ),
                  _detailItem(
                    width: itemWidth / 2,
                    title: 'Tính theo:',
                    description: 'Theo giờ',
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
                title: 'Hình thức thanh toán',
                children: [
                  _detailItem(
                    width: itemWidth / 4,
                    title: 'Hình thức 1:',
                    description: 'Momo',
                  ),
                  _detailItem(
                    width: itemWidth / 4,
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
          Text(
            description,
            style: AppTextTheme.normalText(AppColor.text3),
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
                    'Xóa đặt hàng',
                    style: AppTextTheme.mediumBodyText(AppColor.text8),
                  ),
                ),
              ],
            ),
            onPressed: () {
              _confirmDelete(id: widget.id);
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
            contentText: 'Bạn có muốn xóa đặt hàng này?',
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
    _taskBloc.deleteObject(id: id).then((model) async {
      await Future.delayed(const Duration(milliseconds: 400));
      widget.onFetch(1);
      navigateTo(tasksRoute);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(ScreenUtil.t(I18nKey.deleted)! + ' đặt hàng của ${model.user?.name}.')),
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
