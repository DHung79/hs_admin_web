import 'package:flutter/material.dart';
import '../../core/task/task.dart';
import '/core/admin/model/admin_model.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../layout_template/content_screen.dart';
import 'components/task_detail_content.dart';
import 'components/task_list.dart';

class TaskManagementScreen extends StatefulWidget {
  final String id;
  const TaskManagementScreen({
    Key? key,
    this.id = '',
  }) : super(key: key);

  @override
  State<TaskManagementScreen> createState() => _TaskManagementScreenState();
}

class _TaskManagementScreenState extends State<TaskManagementScreen> {
  final _pageState = PageState();
  final _taskBloc = TaskBloc();
  final _searchController = TextEditingController();

  @override
  void initState() {
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
    return PageTemplate(
      route: tasksRoute,
      title: 'Quản lí đặt hàng',
      subTitle: _getSubTitle(),
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
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
    if (widget.id.isNotEmpty) {
      return TaskDetailContent(
        route: tasksRoute,
        id: widget.id,
        onFetch: _fetchDataOnPage,
      );
    } else {
      return TaskList(
        taskBloc: _taskBloc,
        onFetch: _fetchDataOnPage,
        searchController: _searchController,
        route: tasksRoute,
      );
    }
  }

  String _getSubTitle() {
    if (widget.id.isEmpty) {
      return 'Quản lí đặt hàng / Xem thông tin đặt hàng ';
    } else {
      return 'Quản lí đặt hàng';
    }
  }

  _fetchDataOnPage(int page, {int? limit}) {
    tasksIndex = page;
    tasksSearchString = _searchController.text;
    Map<String, dynamic> params = {
      'limit': limit ?? 10,
      'page': tasksIndex,
      'search_string': tasksSearchString,
    };
    _taskBloc.fetchAllData(params: params);
  }
}
