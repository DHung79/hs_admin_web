import 'package:flutter/material.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/notification/push_noti.dart';
import '../../../main.dart';
import '../../../widgets/joytech_components/joytech_components.dart';
import 'create_edit_push_noti.dart';

class EditPushNotiContent extends StatefulWidget {
  final String route;
  final String id;
  final Function(int, {int? limit}) onFetch;

  const EditPushNotiContent({
    Key? key,
    required this.route,
    required this.id,
    required this.onFetch,
  }) : super(key: key);

  @override
  State<EditPushNotiContent> createState() => _EditPushNotiContentState();
}

class _EditPushNotiContentState extends State<EditPushNotiContent> {
  final _pushNotiBloc = PushNotiBloc();

  @override
  void initState() {
    if (widget.id.isNotEmpty) {
      _pushNotiBloc.fetchDataById(widget.id);
    }
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _pushNotiBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return StreamBuilder(
      stream: _pushNotiBloc.notiData,
      builder: (context, AsyncSnapshot<ApiResponse<PushNotiModel?>> snapshot) {
        if (snapshot.hasData) {
          final pushNoti = snapshot.data!.model;
          return CreateEditPushNoti(
            route: pushNotiManagementRoute,
            pushNoti: pushNoti,
            onFetch: widget.onFetch,
          );
        } else {
          if (snapshot.hasError) {
            logDebug(snapshot.error.toString());
            return ErrorMessageText(
              message:
                  ScreenUtil.t(I18nKey.userNotFound)! + ': ${widget.id}',
            );
          }
          return const JTIndicator();
        }
      },
    );
  }
}
