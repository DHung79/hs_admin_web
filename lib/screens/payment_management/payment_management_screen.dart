import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../widgets/joytech_components/joytech_components.dart';
import '../../core/authentication/auth.dart';
import '../../main.dart';
import '../layout_template/content_screen.dart';

class PaymentManagementScreen extends StatefulWidget {
  final int tab;
  final String id;
  const PaymentManagementScreen({
    Key? key,
    this.tab = 0,
    this.id = '',
  }) : super(key: key);

  @override
  State<PaymentManagementScreen> createState() =>
      _PaymentManagementScreenState();
}

class _PaymentManagementScreenState extends State<PaymentManagementScreen> {
  final _pageState = PageState();

  @override
  void initState() {
    AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    return PageTemplate(
      route: paymentManagementRoute,
      title: 'Quản lí thanh toán',
      subTitle: 'Quản lí thanh toán',
      pageState: _pageState,
      onUserFetched: (user) => setState(() {}),
      onFetch: () {
        _fetchDataOnPage();
      },
      appBarHeight: 0,
      child: ErrorMessageText(
        svgIcon: SvgIcons.wallet,
        message: 'Chức năng sẽ phát triển trong tương lai',
      ),
    );
  }

  _fetchDataOnPage() {}
}
