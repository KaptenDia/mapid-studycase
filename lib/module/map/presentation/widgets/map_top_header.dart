import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/themes/app_colors.dart';
import '../../../../shared/themes/app_text_style.dart';
import '../../domain/map_state.dart';

class MapTopHeader extends StatelessWidget {
  final MapState state;
  final VoidCallback? onTapHeader;
  final VoidCallback? onRefresh;

  const MapTopHeader({
    super.key,
    required this.state,
    this.onTapHeader,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    final layerName = state.layerData?.layerName ?? 'GEO MAPID';
    final featureCount = state.features.length;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.borderCard),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.map_rounded,
              color: AppColors.primaryColor,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(10.r),
              onTap: state.hasFeatures ? onTapHeader : null,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          layerName,
                          style: AppTextStyle.subtitle.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: state.isLayerVisible
                              ? Colors.green.withValues(alpha: 0.12)
                              : Colors.grey.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Text(
                          state.isLayerVisible
                              ? '$featureCount POI'
                              : 'Disembunyikan',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: state.isLayerVisible
                                ? Colors.green[800]
                                : Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.expand_more_rounded,
                        size: 16.sp,
                        color: AppColors.textSecondary,
                      ),
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'OpenFreeMap Liberty • Ketuk untuk lihat daftar',
                    style: AppTextStyle.tiny.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.refresh_rounded,
              size: 20.sp,
              color: AppColors.primaryColor,
            ),
            tooltip: 'Muat Ulang Layer',
            onPressed: onRefresh,
          ),
        ],
      ),
    );
  }
}
