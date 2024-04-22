import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:take_my_tym/core/utils/app_colors.dart';
import 'package:take_my_tym/core/utils/app_padding.dart';
import 'package:take_my_tym/core/utils/app_radius.dart';
import 'package:take_my_tym/core/model/app_post_model.dart';

class PostedContentWidget extends StatelessWidget {
  final String? image;
  final PostModel postModel;
  final double width;
  final VoidCallback voidCallback;
  final double? height;

  const PostedContentWidget({
    this.image,
    required this.voidCallback,
    required this.postModel,
    required this.width,
    this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        voidCallback();
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: MyAppPadding.homePadding,
        ),
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: MyAppDarkColor.instance.secondaryBackground,
            borderRadius: BorderRadius.circular(
              MyAppRadius.borderRadius,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(
              MyAppRadius.borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (image != null)
                  Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          MyAppRadius.borderRadius,
                        ),
                        child: Image.asset(
                          image!,
                          fit: BoxFit.fill,
                          width: MediaQuery.of(context).size.width,
                          height: height,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    'Service Type: ${postModel.workType}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                SizedBox(height: 10.h),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    postModel.title,
                    style: Theme.of(context).textTheme.titleSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (image == null)
                  Column(
                    children: [
                      SizedBox(height: 15.h),
                      Text(
                        postModel.content,
                        style: Theme.of(context).textTheme.bodyLarge,
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
