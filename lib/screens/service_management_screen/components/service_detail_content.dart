import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/authentication/auth.dart';
import '../../../core/service/service.dart';
import '../../../main.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/go_back_button.dart';
import '../../../widgets/joytech_components/error_message_text.dart';
import '../../../widgets/joytech_components/joytech_components.dart';

class ServiceDetailContent extends StatefulWidget {
  final String route;
  final String id;
  final Function(int, {int? limit}) onFetch;

  const ServiceDetailContent({
    Key? key,
    required this.route,
    required this.id,
    required this.onFetch,
  }) : super(key: key);

  @override
  State<ServiceDetailContent> createState() => _ServiceDetailContentState();
}

class _ServiceDetailContentState extends State<ServiceDetailContent> {
  final _scrollController = ScrollController();
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
          final service = snapshot.data!.model!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildProfile(service),
              _deleteButton(),
            ],
          );
        } else {
          if (snapshot.hasError) {
            logDebug(snapshot.error.toString());
            return ErrorMessageText(
              message: 'Không tìm thấy dịch vụ: ${widget.id}',
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
              navigateTo(serviceManagementRoute);
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Thông tin dịch vụ',
                style: AppTextTheme.mediumBigText(AppColor.text3),
              ),
              AppButtonTheme.outlineRounded(
                constraints: const BoxConstraints(minHeight: 44),
                color: AppColor.transparent,
                outlineColor: AppColor.primary2,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: AppColor.primary2,
                        size: 24,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          'Chỉnh sửa',
                          style: AppTextTheme.mediumBodyText(AppColor.primary2),
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  navigateTo(editServiceRoute + '/' + widget.id);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProfile(ServiceModel service) {
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
              child: _avatarField(service),
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
              child: _serviceDetail(service),
            ),
          ],
        ),
      );
    });
  }

  Widget _avatarField(ServiceModel service) {
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
            service.name,
            style: AppTextTheme.mediumBodyText(AppColor.text3),
          ),
        ],
      ),
    );
  }

  Widget _serviceDetail(ServiceModel service) {
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
                      title: 'Loại dịch vụ:',
                      description: service.name,
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
                    description: service.name,
                  ),
                  _detailItem(
                    width: itemWidth / 2,
                    title: 'Giá thành:',
                    description: service.name,
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
                    description: service.createdTime.toString(),
                  ),
                  _detailItem(
                    width: itemWidth / 2,
                    title: 'Cập nhật lần cuối:',
                    description: service.updatedTime.toString(),
                  ),
                  _detailItem(
                    width: itemWidth,
                    title: 'Người cập nhật:',
                    description: service.id,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildPriceDetail({
    required double itemWidth,
    required double numOfItem,
    required PriceModel model,
  }) {
    return Row(
      children: [
        _detailItem(
          width: itemWidth / numOfItem,
          title: 'Tên:',
          description: model.name,
        ),
        _detailItem(
          width: itemWidth / numOfItem,
          title: 'Giá thành:',
          description: model.price,
        ),
        _detailItem(
          width: itemWidth / numOfItem,
          title: 'Tính theo:',
          description: model.type,
        ),
      ],
    );
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
                    'Xóa dịch vụ',
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
            contentText: 'Bạn có muốn xóa dịch vụ này?',
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
    _serviceBloc.deleteObject(id: id).then((model) async {
      await Future.delayed(const Duration(milliseconds: 400));
      widget.onFetch(1);
      navigateTo(serviceManagementRoute);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(ScreenUtil.t(I18nKey.deleted)! + ' ${model.name}.')),
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
