import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../shared/themes/app_colors.dart';

class MapControlButtons extends StatelessWidget {
  final VoidCallback onMyLocation;
  final VoidCallback onRecenterLayer;
  final VoidCallback onToggleLayer;
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;
  final bool isLayerVisible;
  final bool isLocating;

  const MapControlButtons({
    super.key,
    required this.onMyLocation,
    required this.onRecenterLayer,
    required this.onToggleLayer,
    required this.onZoomIn,
    required this.onZoomOut,
    this.isLayerVisible = true,
    this.isLocating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // My Location Button
        _buildFabButton(
          icon: isLocating
              ? SizedBox(
                  width: 18.w,
                  height: 18.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.w,
                    valueColor: const AlwaysStoppedAnimation(AppColors.primaryColor),
                  ),
                )
              : Icon(Icons.my_location_rounded, size: 22.sp, color: AppColors.primaryColor),
          tooltip: 'Lokasi Saya (GPS)',
          onTap: onMyLocation,
        ),
        SizedBox(height: 10.h),

        // Recenter to Layer POIs
        _buildFabButton(
          icon: Icon(Icons.layers_rounded, size: 22.sp, color: AppColors.primaryColor),
          tooltip: 'Pusatkan ke Layer Jogja',
          onTap: onRecenterLayer,
        ),
        SizedBox(height: 10.h),

        // Toggle Layer Visibility
        _buildFabButton(
          icon: Icon(
            isLayerVisible ? Icons.visibility_rounded : Icons.visibility_off_rounded,
            size: 22.sp,
            color: isLayerVisible ? AppColors.primaryColor : Colors.grey,
          ),
          tooltip: isLayerVisible ? 'Sembunyikan Layer' : 'Tampilkan Layer',
          onTap: onToggleLayer,
        ),
        SizedBox(height: 10.h),

        // Zoom Controls Card
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(color: AppColors.borderCard),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.add_rounded),
                iconSize: 22.sp,
                color: AppColors.textPrimary,
                onPressed: onZoomIn,
                tooltip: 'Perbesar',
              ),
              Container(width: 28.w, height: 1, color: AppColors.borderCard),
              IconButton(
                icon: const Icon(Icons.remove_rounded),
                iconSize: 22.sp,
                color: AppColors.textPrimary,
                onPressed: onZoomOut,
                tooltip: 'Perkecil',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFabButton({
    required Widget icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.borderCard),
      ),
      child: Material(
        color: Colors.transparent,
        child: Tooltip(
          message: tooltip,
          child: InkWell(
            borderRadius: BorderRadius.circular(14.r),
            onTap: onTap,
            child: Container(
              width: 44.w,
              height: 44.w,
              alignment: Alignment.center,
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
