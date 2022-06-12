import 'package:flutter/material.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/service/service.dart';
import '../../../main.dart';
import '../../../widgets/joytech_components/error_message_text.dart';
import '../../../widgets/joytech_components/joytech_components.dart';
import 'create_edit_service_form.dart';

class EditServiceContent extends StatefulWidget {
  final String route;
  final String id;
  final Function(int, {int? limit}) onFetch;

  const EditServiceContent({
    Key? key,
    required this.route,
    required this.id,
    required this.onFetch,
  }) : super(key: key);

  @override
  State<EditServiceContent> createState() => _EditServiceContentState();
}

class _EditServiceContentState extends State<EditServiceContent> {
  final _serviceBloc = ServiceBloc();

  @override
  void initState() {
    if (widget.id.isNotEmpty) {
      _serviceBloc.fetchDataById(widget.id);
    }
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _serviceBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return StreamBuilder(
      stream: _serviceBloc.serviceData,
      builder: (context, AsyncSnapshot<ApiResponse<ServiceModel?>> snapshot) {
        if (snapshot.hasData) {
          final service = snapshot.data!.model;
          return CreateEditServiceForm(
            serviceBloc: _serviceBloc,
            route: serviceManagementRoute,
            serviceModel: service,
            onFetch: widget.onFetch,
          );
        } else {
          if (snapshot.hasError) {
            logDebug(snapshot.error.toString());
            return ErrorMessageText(
              message:
                  'Không tìm thấy dịch vụ: ${widget.id}',
            );
          }
          return const JTIndicator();
        }
      },
    );
  }
}
