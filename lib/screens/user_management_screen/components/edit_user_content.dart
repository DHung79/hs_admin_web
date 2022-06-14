import 'package:flutter/material.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/user/user.dart';
import '../../../main.dart';
import '../../../widgets/joytech_components/joytech_components.dart';
import 'create_edit_user_form.dart';

class EditUserContent extends StatefulWidget {
  final String route;
  final String userId;
  final Function(int, {int? limit}) onFetch;

  const EditUserContent({
    Key? key,
    required this.route,
    required this.userId,
    required this.onFetch,
  }) : super(key: key);

  @override
  State<EditUserContent> createState() => _EditUserContentState();
}

class _EditUserContentState extends State<EditUserContent> {
  final _userBloc = UserBloc();

  @override
  void initState() {
    if (widget.userId.isNotEmpty) {
      _userBloc.fetchDataById(widget.userId);
    }
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _userBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return StreamBuilder(
      stream: _userBloc.userData,
      builder: (context, AsyncSnapshot<ApiResponse<UserModel?>> snapshot) {
        if (snapshot.hasData) {
          final user = snapshot.data!.model;
          return CreateEditUserForm(
            userBloc: _userBloc,
            route: userManagementRoute,
            userModel: user,
            onFetch: widget.onFetch,
          );
        } else {
          if (snapshot.hasError) {
            logDebug(snapshot.error.toString());
            return ErrorMessageText(
              message:
                  ScreenUtil.t(I18nKey.userNotFound)! + ': ${widget.userId}',
            );
          }
          return const JTIndicator();
        }
      },
    );
  }
}
