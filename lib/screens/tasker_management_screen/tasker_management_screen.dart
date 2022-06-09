import 'package:flutter/material.dart';
import '../../core/tasker/tasker.dart';
import '/core/admin/model/admin_model.dart';
import '/routes/route_names.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../layout_template/content_screen.dart';
import 'components/create_edit_tasker_form.dart';
import 'components/edit_tasker_content.dart';
import 'components/tasker_info_content.dart';
import 'components/tasker_list.dart';

class TaskerManagementScreen extends StatefulWidget {
  final int tab;
  final String id;
  const TaskerManagementScreen({
    Key? key,
    this.tab = 0,
    this.id = '',
  }) : super(key: key);

  @override
  State<TaskerManagementScreen> createState() => _TaskerManagementScreenState();
}

class _TaskerManagementScreenState extends State<TaskerManagementScreen> {
  final _pageState = PageState();
  final _taskerBloc = TaskerBloc();
  final _searchController = TextEditingController();

  @override
  void initState() {
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
    return PageTemplate(
      title: 'Quản lí người giúp việc',
      subTitle: _getSubTitle(),
      pageState: _pageState,
      onUserFetched: (tasker) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage(1);
      },
      appBarHeight: 0,
      child: FutureBuilder(
          future: _pageState.currentUser,
          builder: (context, AsyncSnapshot<AdminModel> snapshot) {
            return PageContent(
              userSnapshot: snapshot,
              pageState: _pageState,
              onFetch: () {
                _fetchDataOnPage(1);
              },
              child: _buildContent(),
            );
          }),
    );
  }

  Widget _buildContent() {
    if (widget.tab == 1) {
      return CreateEditTaskerForm(
        taskerBloc: _taskerBloc,
        route: taskerManagementRoute,
        onFetch: _fetchDataOnPage,
      );
    } else if (widget.tab == 2) {
      return TaskerInfoContent(
        route: taskerManagementRoute,
        taskerId: widget.id,
        onFetch: _fetchDataOnPage,
      );
    } else if (widget.tab == 3) {
      return EditTaskerContent(
        route: taskerManagementRoute,
        taskerId: widget.id,
        onFetch: _fetchDataOnPage,
      );
    } else {
      return TaskerList(
        taskerBloc: _taskerBloc,
        onFetch: _fetchDataOnPage,
        searchController: _searchController,
        route: taskerManagementRoute,
      );
    }
  }

  String _getSubTitle() {
    if (widget.tab == 1) {
      return 'Quản lí người giúp việc / Chỉnh sửa thông tin người giúp việc';
    } else if (widget.tab == 2) {
      return 'Quản lí người giúp việc / Xem thông tin người giúp việc ';
    } else {
      return 'Quản lí người giúp việc';
    }
  }

  _fetchDataOnPage(int page, {int? limit}) {
    taskerManagementIndex = page;
    taskerManagementSearchString = _searchController.text;
    Map<String, dynamic> params = {
      'limit': limit ?? 10,
      'page': taskerManagementIndex,
      'search_string': taskerManagementSearchString,
    };
    _taskerBloc.fetchAllData(params: params);
  }
}
