import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '/core/tasker/model/tasker_model.dart';
import '../../../theme/app_theme.dart';

class TaskerRatingDialog extends StatefulWidget {
  final TaskerModel tasker;
  const TaskerRatingDialog({
    Key? key,
    required this.tasker,
  }) : super(key: key);

  @override
  State<TaskerRatingDialog> createState() => _TaskerRatingDialogState();
}

class _TaskerRatingDialogState extends State<TaskerRatingDialog> {
  final _rateNumber = 4.5;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        content: SingleChildScrollView(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 458,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 34),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Chi tiết đánh giá',
                          style: AppTextTheme.normalText(
                            AppColor.black,
                          ),
                        ),
                        InkWell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgIcon(
                              SvgIcons.close,
                              color: AppColor.black,
                              size: 24,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                  _taskerAvatar(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: _taskerMedal(),
                  ),
                  _taskerRatingDetail(),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  _taskerAvatar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.asset(
            "assets/images/logo.png",
            width: 100,
            height: 100,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Text(
            widget.tasker.name,
            style: AppTextTheme.mediumBigText(AppColor.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar.builder(
                    ignoreGestures: true,
                    allowHalfRating: true,
                    initialRating: 4.5,
                    minRating: 1,
                    itemCount: 5,
                    itemSize: 24,
                    direction: Axis.horizontal,
                    unratedColor: AppColor.primary2,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 3),
                    itemBuilder: (context, index) {
                      return SvgIcon(
                        _rateNumber.floor() == index
                            ? SvgIcons.starHalf
                            : _rateNumber.floor() > index
                                ? SvgIcons.star
                                : SvgIcons.starOutline,
                        color: AppColor.primary2,
                      );
                    },
                    onRatingUpdate: (value) {},
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Text(
                      _rateNumber.toString(),
                      style: AppTextTheme.normalHeaderTitle(AppColor.black),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  '(643 đánh giá)',
                  style: AppTextTheme.normalHeaderTitle(
                    AppColor.text3,
                  ),
                ),
              ),
            ],
          ),
        ),
        _buildJobHistory(),
      ],
    );
  }

  Widget _buildJobHistory() {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _jobHistoryItem(
            title: 'Tham gia từ',
            content: '3/2019',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: VerticalDivider(
              thickness: 1,
            ),
          ),
          _jobHistoryItem(
            title: 'Công việc',
            content: '320',
          ),
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ),
            child: VerticalDivider(
              thickness: 1,
            ),
          ),
          _jobHistoryItem(
            title: 'Đánh giá tích cực',
            content: '90%',
          )
        ],
      ),
    );
  }

  Widget _jobHistoryItem({
    required String title,
    required String content,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              title,
              style: AppTextTheme.mediumBodyText(AppColor.text7),
            ),
          ),
          Text(
            content,
            style: AppTextTheme.mediumBodyText(AppColor.primary1),
          ),
        ],
      ),
    );
  }

  Widget _taskerMedal() {
    final medals = widget.tasker.gender != 'male' ? 8 : 0;

    return Column(
      children: [
        SizedBox(
          height: 44,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Huy hiệu',
                    style: AppTextTheme.mediumHeaderTitle(
                      AppColor.black,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    '7 huy hiệu',
                    style: AppTextTheme.normalText(
                      AppColor.primary2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (medals > 0)
          SizedBox(
            width: 450,
            height: 111,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: medals,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 17,
                  ),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.primary2,
                          ),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            "assets/images/logo.png",
                            width: 58,
                            height: 58,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          widget.tasker.name,
                          style: AppTextTheme.subText(AppColor.black),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _taskerRatingDetail() {
    final _taskerRatingComment = widget.tasker.gender != 'male'
        ? [
            RatingComment(
              comment: '“Bạn làm rất tốt! Xứng đáng tăng lương”',
              user: 'Ngo Anh Duong',
              rating: 4.5,
            ),
            RatingComment(
              comment: '“Hôm qua em tuyệt lắm!”',
              user: 'Chi Nhan',
              rating: 5.0,
            ),
            RatingComment(
              comment: '“Hôm qua em tuyệt lắm!”',
              user: 'Chi Nhan',
              rating: 5.0,
            ),
            RatingComment(
              comment: '“Hôm qua em tuyệt lắm!”',
              user: 'Chi Nhan',
              rating: 5.0,
            ),
          ]
        : [];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Đánh giá tiêu biểu',
              style: AppTextTheme.mediumHeaderTitle(
                AppColor.black,
              ),
            ),
          ),
          _taskerRatingComment.isNotEmpty
              ? Column(
                  children: [
                    for (var item in _taskerRatingComment)
                      Container(
                        constraints: const BoxConstraints(minHeight: 76),
                        width: 426,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 4),
                                    child: Text(
                                      item.comment,
                                      style: AppTextTheme.mediumBodyText(
                                          AppColor.black),
                                    ),
                                  ),
                                  Text(
                                    item.user,
                                    style: AppTextTheme.mediumBodyText(
                                        AppColor.text7),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 85,
                              constraints: const BoxConstraints(minHeight: 44),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColor.shade1),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgIcon(
                                    SvgIcons.star1,
                                    size: 24,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 9),
                                    child: Text(
                                      item.rating.toString(),
                                      style: AppTextTheme.normalText(
                                          AppColor.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                )
              : Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          "assets/images/image2.png",
                          width: 195,
                          height: 195,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Chưa có đánh giá',
                          style: AppTextTheme.normalText(AppColor.text8),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

class RatingComment {
  final String comment;
  final String user;
  final double rating;
  RatingComment({
    required this.comment,
    required this.user,
    required this.rating,
  });
}
