import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/joytech_components/joytech_components.dart';
import '/core/admin/bloc/admin_bloc.dart';
import '/core/admin/model/admin_model.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../../theme/app_theme.dart';
import 'components/top_navigation_bar.dart';
import 'components/sidebar.dart';

class PageTemplate extends StatefulWidget {
  final Widget child;
  final PageState? pageState;
  final void Function(AdminModel?) onUserFetched;
  final Widget? navItem;
  final Widget? tabTitle;
  final int? currentTab;
  final Widget? leading;
  final Widget? drawer;
  final List<Widget>? actions;
  final double elevation;
  final double appBarHeight;
  final Widget? flexibleSpace;
  final bool showAppBar;
  final void Function() onFetch;
  final Widget? appBar;
  final String title;
  final String subTitle;
  final String route;

  const PageTemplate({
    Key? key,
    required this.child,
    this.pageState,
    required this.onUserFetched,
    this.navItem,
    this.tabTitle,
    this.currentTab,
    this.leading,
    this.drawer,
    this.actions,
    this.elevation = 0,
    this.appBarHeight = 56,
    this.flexibleSpace,
    this.showAppBar = true,
    required this.onFetch,
    this.appBar,
    required this.title,
    required this.subTitle,
    required this.route,
  }) : super(key: key);

  @override
  State<PageTemplate> createState() => _PageTemplateState();
}

class _PageTemplateState extends State<PageTemplate> {
  late AuthenticationBloc _authenticationBloc;
  Future<AdminModel>? _currentUser;
// int _totalNotifications;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final _adminBloc = AdminBloc();

  @override
  void initState() {
    _authenticationBloc = AuthenticationBlocController().authenticationBloc;
    _authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    _adminBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      bloc: _authenticationBloc,
      listener: (BuildContext context, AuthenticationState state) async {
        if (state is AuthenticationStart) {
          navigateTo(authenticationRoute);
        } else if (state is UserLogoutState) {
          navigateTo(authenticationRoute);
        } else if (state is AuthenticationFailure) {
          _showError(state.errorCode);
        } else if (state is UserTokenExpired) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                ScreenUtil.t(I18nKey.signInSessionExpired)!,
              ),
            ),
          );
          navigateTo(authenticationRoute);
        } else if (state is AppAutheticated) {
          _authenticationBloc.add(GetUserData());
        } else if (state is SetUserData<AdminModel>) {
          _currentUser = Future.value(state.currentUser);
        }
      },
      child: FutureBuilder(
        future: _currentUser,
        builder: (context, AsyncSnapshot<AdminModel> snapshot) {
          return Scaffold(
            key: _key,
            backgroundColor: Colors.white,
            appBar: widget.showAppBar
                ? PreferredSize(
                    preferredSize: Size.fromHeight(widget.appBarHeight),
                    child: widget.appBar ??
                        AppBar(
                          backgroundColor: Colors.white,
                          flexibleSpace: widget.flexibleSpace,
                          centerTitle: widget.currentTab != 0,
                          leading: widget.leading,
                          actions: widget.actions,
                          title: widget.tabTitle,
                          elevation: widget.elevation,
                        ),
                  )
                : null,
            drawer: widget.drawer,
            bottomNavigationBar: widget.navItem,
            body: LayoutBuilder(
              builder: (context, size) {
                return BlocListener<AuthenticationBloc, AuthenticationState>(
                  bloc: AuthenticationBlocController().authenticationBloc,
                  listener: (BuildContext context, AuthenticationState state) {
                    if (state is SetUserData<AdminModel>) {
                      widget.pageState!.currentUser = Future.value(
                        state.currentUser,
                      );
                      // App.of(context)!.setLocale(
                      //   supportedLocales.firstWhere(
                      //       (e) => e.languageCode == state.currentLang),
                      // );
                      widget.onUserFetched(state.currentUser);
                    }
                  },
                  child: _buildContent(snapshot),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(AsyncSnapshot<AdminModel> snapshot) {
    final _scrollController = ScrollController();
    return Container(
      color: AppColor.shade1,
      child: Row(
        children: [
          SideBar(route: widget.route),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                snapshot.hasData
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: TopNavigationBar(
                          admin: snapshot.data!,
                          routeName: widget.title,
                          subTitle: widget.subTitle,
                          onPressed: () {},
                        ),
                      )
                    : const JTIndicator(),
                Expanded(
                    child: Scrollbar(
                  thumbVisibility: _scrollController.hasClients,
                  controller: _scrollController,
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: widget.child,
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showError(String errorCode) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(showError(errorCode, context))),
    );
  }
}

class PageContent extends StatelessWidget {
  final AsyncSnapshot<AdminModel> userSnapshot;
  final PageState pageState;
  final void Function()? onFetch;
  final Widget child;

  const PageContent({
    Key? key,
    required this.userSnapshot,
    required this.pageState,
    required this.child,
    this.onFetch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!userSnapshot.hasData) {
      return const JTIndicator();
    }

    if (!pageState.isInitData) {
      if (onFetch != null) onFetch!();
      pageState.isInitData = true;
    }

    return child;
  }
}

class PageState {
  bool isInitData = false;
  Future<AdminModel>? currentUser;
}
