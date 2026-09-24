import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_style.dart';
import '../../data/model/geo_layer_model.dart';

class MapPopupSheet extends StatelessWidget {
  final GeoFeature feature;
  final VoidCallback onDismiss;
  final VoidCallback? onFocus;

  const MapPopupSheet({
    super.key,
    required this.feature,
    required this.onDismiss,
    this.onFocus,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.14),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: AppColors.borderCard),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with Pin Icon, Title, and Close Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.place_rounded,
                  color: AppColors.primaryColor,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature.nama,
                      style: AppTextStyle.subtitle.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                        fontSize: 15.sp,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (feature.waktu.isNotEmpty) ...[
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          'Periode: ${feature.waktu}',
                          style: AppTextStyle.tiny.copyWith(
                            color: Colors.amber[900],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close_rounded),
                iconSize: 20.sp,
                color: AppColors.textSecondary,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: onDismiss,
              ),
            ],
          ),

          SizedBox(height: 14.h),
          const Divider(height: 1, color: AppColors.borderCard),
          SizedBox(height: 12.h),

          // Address
          if (feature.alamat.isNotEmpty && feature.alamat != '-') ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.near_me_outlined,
                  size: 16.sp,
                  color: AppColors.textSecondary,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    feature.alamat,
                    style: AppTextStyle.caption.copyWith(
                      color: AppColors.textPrimary,
                      height: 1.35,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
          ],

          // Region Chips
          Wrap(
            spacing: 6.w,
            runSpacing: 6.h,
            children: [
              if (feature.kecamatan.isNotEmpty)
                _buildInfoChip(Icons.domain_rounded, 'Kec. ${feature.kecamatan}'),
              if (feature.kabkot.isNotEmpty)
                _buildInfoChip(Icons.location_city_rounded, feature.kabkot),
              if (feature.provinsi.isNotEmpty)
                _buildInfoChip(Icons.map_outlined, feature.provinsi),
            ],
          ),

          SizedBox(height: 12.h),

          // Coordinates & Focus Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.backgroundField,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${feature.latitude.toStringAsFixed(5)}, ${feature.longitude.toStringAsFixed(5)}',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 11.sp,
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (onFocus != null)
                TextButton.icon(
                  onPressed: onFocus,
                  icon: Icon(Icons.my_location_rounded, size: 16.sp),
                  label: Text('Fokus', style: TextStyle(fontSize: 12.sp)),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    backgroundColor: AppColors.primaryColor.withValues(alpha: 0.08),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.backgroundMenu,
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12.sp, color: AppColors.primaryColor),
          SizedBox(width: 4.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
