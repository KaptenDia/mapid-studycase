import 'package:flutter/material.dart';

import '../../config/di/di.dart';
import '../../helper/navigator.dart';
import 'themes.dart';

AppBar appBarDefault(String title, {Function()? onPressed}) => AppBar(
  backgroundColor: AppColors.backgroundPrimary,
  elevation: 0.5,
  centerTitle: true,
  // automaticallyImplyLeading: true,
  titleSpacing: 0,
  leading: IconButton(
    icon: const Icon(
      Icons.arrow_back_ios,
      color: AppColors.textPrimary,
      size: 20,
    ),
    onPressed: () =>
        onPressed != null ? onPressed() : getIt<AppNavigator>().pop(),
  ),
  title: Text(title, style: AppTextStyle.appBar),
);
