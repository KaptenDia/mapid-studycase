import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_style.dart';
import '../../data/model/geo_layer_model.dart';

class MapPoiListSheet extends StatelessWidget {
  final List<GeoFeature> features;
  final ValueChanged<GeoFeature> onSelectFeature;

  const MapPoiListSheet({
    super.key,
    required this.features,
    required this.onSelectFeature,
  });

  static Future<void> show(
    BuildContext context, {
    required List<GeoFeature> features,
    required ValueChanged<GeoFeature> onSelectFeature,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => MapPoiListSheet(
        features: features,
        onSelectFeature: onSelectFeature,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.75,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Grab handle
          SizedBox(height: 12.h),
          Container(
            width: 38.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 14.h),

          // Title Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Daftar Objek Wisata (${features.length} POI)',
                      style: AppTextStyle.subtitle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'Pilih objek untuk fokus dan melihat detailnya di peta',
                      style: AppTextStyle.caption.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          const Divider(height: 20, color: AppColors.borderCard),

          // POI List
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              itemCount: features.length,
              separatorBuilder: (_, __) => SizedBox(height: 8.h),
              itemBuilder: (context, index) {
                final feature = features[index];
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.backgroundCard,
                    borderRadius: BorderRadius.circular(14.r),
                    border: Border.all(color: AppColors.borderCard),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 4.h,
                    ),
                    leading: Container(
                      width: 32.w,
                      height: 32.w,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ),
                    title: Text(
                      feature.nama,
                      style: AppTextStyle.body.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (feature.alamat.isNotEmpty &&
                            feature.alamat != '-') ...[
                          SizedBox(height: 2.h),
                          Text(
                            feature.alamat,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyle.tiny.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                        if (feature.kecamatan.isNotEmpty) ...[
                          SizedBox(height: 4.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 6.w,
                              vertical: 2.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.backgroundMenu,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              'Kec. ${feature.kecamatan}',
                              style: TextStyle(
                                fontSize: 10.sp,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 14.sp,
                      color: AppColors.hintTextColor,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      onSelectFeature(feature);
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
