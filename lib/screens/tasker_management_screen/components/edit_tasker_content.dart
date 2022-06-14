import 'package:flutter/material.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/tasker/tasker.dart';
import '../../../main.dart';
import '../../../widgets/joytech_components/joytech_components.dart';
import 'create_edit_tasker_form.dart';

class EditTaskerContent extends StatefulWidget {
  final String route;
  final String taskerId;
  final Function(int, {int? limit}) onFetch;

  const EditTaskerContent({
    Key? key,
    required this.route,
    required this.taskerId,
    required this.onFetch,
  }) : super(key: key);

  @override
  State<EditTaskerContent> createState() => _EditTaskerContentState();
}

class _EditTaskerContentState extends State<EditTaskerContent> {
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
          final tasker = snapshot.data!.model;
          return CreateEditTaskerForm(
            taskerBloc: _taskerBloc,
            route: taskerManagementRoute,
            taskerModel: tasker,
            onFetch: widget.onFetch,
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
}
