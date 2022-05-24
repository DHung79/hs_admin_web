// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:hs_admin_web/core/admin/model/admin_model.dart';
// import 'package:hs_admin_web/routes/route_names.dart';
// import '../../configs/button_theme.dart';
// import '../../configs/svg_constants.dart';
// import '../../configs/text_theme.dart';
// import '../../configs/themes.dart';
// import '../../core/authentication/auth.dart';
// import '../../main.dart';
// import '../layout_template/content_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   final _pageState = PageState();
//   @override
//   void initState() {
//     AuthenticationBlocController().authenticationBloc.add(AppLoadedup());
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     ScreenUtil.init(context);
//     return PageTemplate(
//       pageState: _pageState,
//       onUserFetched: (user) => setState(() {}),
//       onFetch: () {
//         _fetchDataOnPage();
//       },
//       appBarHeight: 0,
//       child: FutureBuilder(
//           future: _pageState.currentUser,
//           builder: (context, AsyncSnapshot<AdminModel> snapshot) {
//             return PageContent(
//               userSnapshot: snapshot,
//               pageState: _pageState,
//               onFetch: () {
//                 _fetchDataOnPage();
//               },
//               child: snapshot.hasData ? _homePage(snapshot) : const SizedBox(),
//             );
//           }),
//     );
//   }

//   Widget _homePage(AsyncSnapshot<AdminModel> snapshot) {
//     final admin = snapshot.data;
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(146),
//         child: _appBar(admin!),
//       ),
//       body: _buildContent(),
//     );
//   }

//   Widget _appBar(AdminModel admin) {
//     return AppBar(
//       backgroundColor: Colors.white,
//       elevation: 0.16,
//       flexibleSpace: Column(
//         children: [
//           SizedBox(
//             height: 96,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Row(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 24, 8, 24),
//                     child: ClipOval(
//                       child: Image.asset(
//                         'assets/images/logo.png',
//                         width: 48,
//                         height: 48,
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.fromLTRB(8, 28, 32, 24),
//                       child: _taskerInfo(admin),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.fromLTRB(0, 27, 8, 27),
//                     child: InkWell(
//                       child: _buildNoti(),
//                       onTap: () {
//                         setState(() {
//                           notiBadges = 0;
//                           navigateTo(notificationManageRoute);
//                         });
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 50,
//             child: _appBarNavigation(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildNoti() {
//     bool hasNoti = notiBadges != 0;
//     return Container(
//       width: hasNoti ? 76 : 42,
//       height: 42,
//       decoration: BoxDecoration(
//         boxShadow: <BoxShadow>[
//           BoxShadow(
//             color: WebColor.gradientColor1A.withOpacity(0.16),
//             blurRadius: 4,
//             blurStyle: BlurStyle.outer,
//           ),
//         ],
//         borderRadius: hasNoti ? BorderRadius.circular(50) : null,
//         shape: hasNoti ? BoxShape.rectangle : BoxShape.circle,
//       ),
//       child: hasNoti
//           ? Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const Icon(Icons.notifications_outlined),
//                 Container(
//                   width: 26,
//                   height: 26,
//                   decoration: const BoxDecoration(
//                     color: WebColor.textColor1,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Center(
//                     child: Text(
//                       notiBadges > 9 ? '9+' : '$notiBadges',
//                       style: WebTextTheme().mediumBodyText(
//                         Colors.white,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           : const Icon(Icons.notifications_outlined),
//     );
//   }

//   Widget _taskerInfo(AdminModel admin) {
//     return InkWell(
//       highlightColor: Colors.white,
//       splashColor: Colors.white,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(bottom: 4),
//             child: Text(
//               admin.name,
//               style: WebTextTheme().normalText(WebColor.textColor1),
//             ),
//           ),
//           Row(
//             children: [
//               Text(
//                 'Xem thêm',
//                 style: WebTextTheme().subText(WebColor.textColor1),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 4),
//                 child: Transform.rotate(
//                   angle: 180 * pi / 180,
//                   child: SvgIcon(
//                     SvgIcons.arrowBack,
//                     color: WebColor.textColor1,
//                     size: 18,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//       onTap: () {
//         // navigateTo(taskerProfileRoute);
//       },
//     );
//   }

//   Widget _appBarNavigation() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         _headerButton(
//           index: 0,
//           title: 'Trang tin mới',
//           onPressed: () {
//             setState(() {
//               homeTabIndex = 0;
//             });
//           },
//         ),
//         _headerButton(
//           index: 1,
//           title: 'Hiện tại',
//           onPressed: () {
//             setState(() {
//               homeTabIndex = 1;
//             });
//           },
//         ),
//         _headerButton(
//           index: 2,
//           title: 'Lịch sử',
//           onPressed: () {
//             setState(() {
//               homeTabIndex = 2;
//             });
//           },
//         ),
//       ],
//     );
//   }

//   Widget _headerButton({
//     required String title,
//     required void Function()? onPressed,
//     required int index,
//   }) {
//     final bool isSelected = index == homeTabIndex;
//     return Expanded(
//       child: AppButtonTheme.underLine(
//         onPressed: onPressed,
//         lineColor: isSelected ? WebColor.textColor1 : Colors.white,
//         lineWidth: 4,
//         child: Text(
//           title,
//           style: WebTextTheme().normalText(
//             isSelected ? WebColor.textColor1 : WebColor.textColor1,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContent() {
//     return LayoutBuilder(builder: (context, size) {
//       return ListView.builder(
//         shrinkWrap: true,
//         physics: const ClampingScrollPhysics(),
//         itemCount: 3,
//         itemBuilder: (BuildContext context, index) {
//           return Padding(
//             padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
//             child: Container(
//               constraints: BoxConstraints(
//                 minHeight: 408,
//                 minWidth: size.maxWidth - 32,
//               ),
//               decoration: BoxDecoration(
//                 boxShadow: <BoxShadow>[
//                   BoxShadow(
//                     color: WebColor.secondaryColor1.withOpacity(0.16),
//                     blurRadius: 24,
//                     spreadRadius: 0.16,
//                     blurStyle: BlurStyle.outer,
//                   ),
//                 ],
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: _buildTask(index: index),
//             ),
//           );
//         },
//       );
//     });
//   }

//   Widget _buildTask({required int index}) {
//     final Color tagColor = homeTabIndex == 1
//         ? WebColor.textColor1
//         : index != 0
//             ? WebColor.textColor1
//             : WebColor.textColor1;
//     final Color tagTextColor = homeTabIndex == 2
//         ? Colors.white
//         : index != 0
//             ? WebColor.textColor1
//             : WebColor.textColor1;
//     return LayoutBuilder(builder: (context, constraints) {
//       return Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Container(
//               constraints: const BoxConstraints(minHeight: 42),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Dọn dẹp theo giờ',
//                         style: WebTextTheme()
//                             .mediumHeaderAndTitle(WebColor.textColor1),
//                       ),
//                       Text(
//                         'Vừa mới',
//                         style: WebTextTheme().normalText(WebColor.textColor1),
//                       ),
//                     ],
//                   ),
//                   if (homeTabIndex != 0)
//                     Container(
//                       decoration: BoxDecoration(
//                         color: tagColor,
//                         borderRadius: BorderRadius.circular(50),
//                       ),
//                       child: Padding(
//                         padding: const EdgeInsets.symmetric(
//                           vertical: 4,
//                           horizontal: 10,
//                         ),
//                         child: Text(
//                           'Đang diễn ra',
//                           style:
//                               WebTextTheme().mediumHeaderAndTitle(tagTextColor),
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 6),
//               child: Divider(
//                 thickness: 1.5,
//                 color: WebColor.textColor1,
//               ),
//             ),
//             _taskContent(),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: 6),
//               child: Divider(
//                 thickness: 1.5,
//                 color: WebColor.textColor1,
//               ),
//             ),
//             AppButtonTheme.outlineRounded(
//               constraints: const BoxConstraints(minHeight: 56),
//               outlineColor: homeTabIndex == 1 && index == 0
//                   ? WebColor.textColor1
//                   : WebColor.textColor1,
//               color:
//                   homeTabIndex == 1 && index == 0 ? WebColor.textColor1 : null,
//               borderRadius: BorderRadius.circular(4),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     'Xem chi tiết',
//                     style: homeTabIndex == 1 && index == 0
//                         ? WebTextTheme().headerAndTitle(Colors.white)
//                         : WebTextTheme()
//                             .mediumHeaderAndTitle(WebColor.textColor1),
//                   ),
//                   if (homeTabIndex != 1)
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10),
//                       child: Transform.rotate(
//                         angle: 180 * pi / 180,
//                         child: SvgIcon(
//                           SvgIcons.arrowBack,
//                           color: WebColor.textColor1,
//                           size: 18,
//                         ),
//                       ),
//                     ),
//                 ],
//               ),
//               onPressed: () {
//                 if (homeTabIndex == 0) {
//                   navigateTo(userManageRoute);
//                 }
//                 if (homeTabIndex == 1) {
//                   navigateTo(taskerManageRoute);
//                 }
//                 if (homeTabIndex == 2) {
//                   navigateTo(payManageRoute);
//                 }
//               },
//             ),
//           ],
//         ),
//       );
//     });
//   }

//   Widget _taskContent() {
//     return Column(
//       children: [
//         Container(
//           constraints: const BoxConstraints(minHeight: 59),
//           decoration: BoxDecoration(
//             color: WebColor.textColor1,
//             borderRadius: BorderRadius.circular(4),
//           ),
//           child: IntrinsicHeight(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 1,
//                     child: _taskHeader(
//                       headerTitle: 'Thời lượng',
//                       contentTitle: '2 tiếng (14:00)',
//                     ),
//                   ),
//                   const VerticalDivider(
//                     thickness: 2,
//                     color: WebColor.textColor1,
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: _taskHeader(
//                       headerTitle: 'Tổng tiền (VND)',
//                       contentTitle: '300.000',
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//         _taskDetail(
//           svgIcon: SvgIcons.time,
//           headerTitle: 'Thời gian làm',
//           contentTitle: 'Ngày mai, từ 14:00 đến 16:00',
//         ),
//         _taskDetail(
//           svgIcon: SvgIcons.location,
//           headerTitle: 'Địa chỉ',
//           contentTitle: '358/12/33 Lư Cấm, Ngọc Hiệp',
//         ),
//         _taskDetail(
//           svgIcon: SvgIcons.car,
//           headerTitle: 'Khoảng cách',
//           contentTitle: '4km',
//         ),
//       ],
//     );
//   }

//   Widget _taskHeader({
//     String? contentTitle,
//     String? headerTitle,
//   }) {
//     return Column(
//       children: [
//         Text(
//           headerTitle ?? '',
//           style: WebTextTheme().subText(WebColor.textColor1),
//         ),
//         Text(
//           contentTitle ?? '',
//           style: WebTextTheme().mediumHeaderAndTitle(WebColor.textColor1),
//         ),
//       ],
//     );
//   }

//   Widget _taskDetail({
//     IconData? icon,
//     SvgIconData? svgIcon,
//     String? contentTitle,
//     String? headerTitle,
//   }) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 12),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(right: 8),
//             child: Container(
//               width: 44,
//               height: 44,
//               decoration: BoxDecoration(
//                 color: WebColor.textColor1,
//                 borderRadius: BorderRadius.circular(4),
//               ),
//               child: Center(
//                 child: icon != null
//                     ? Icon(
//                         icon,
//                         size: 20,
//                         color: WebColor.textColor1,
//                       )
//                     : SvgIcon(
//                         svgIcon,
//                         size: 20,
//                         color: WebColor.textColor1,
//                       ),
//               ),
//             ),
//           ),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 headerTitle ?? '',
//                 style: WebTextTheme().normalText(WebColor.textColor1),
//               ),
//               Text(
//                 contentTitle ?? '',
//                 style: WebTextTheme().mediumBodyText(WebColor.textColor1),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   _fetchDataOnPage() {}
// }
