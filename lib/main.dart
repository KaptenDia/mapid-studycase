import 'package:flutter/services.dart';
import 'flavors.dart';
import 'package:mapid/module/splash/presentation/splash_screen.dart';
import 'package:encrypt_shared_preferences/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mapid/shared/translation/translation_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mapid/helper/samseer_notification_bridge.dart';
import 'config/di/di.dart';
import 'package:mapid/helper/navigator.dart';
import 'shared/themes/themes.dart';
import 'shared/translation/translation_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  F.appFlavor = Flavor.values.firstWhere(
    (element) => element.name == appFlavor,
    orElse: () => Flavor.dev,
  );

  await configureDependencies();
  await ScreenUtil.ensureScreenSize();
  await EncryptedSharedPreferences.initialize('e7be0216a6af5cf5');
  await getIt<TranslationService>().init();

  if (F.appFlavor == Flavor.dev || F.appFlavor == Flavor.staging) {
    final notifications = FlutterLocalNotificationsPlugin();
    final bridge = SamseerNotificationBridge(
      samseer: samseer,
      plugin: notifications,
    );

    await notifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
      onDidReceiveNotificationResponse: bridge.handleTap,
    );

    bridge.start();
  }

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final translationService = getIt<TranslationService>();

    return ScreenUtilInit(
      designSize: const Size(375, 805),
      child: TranslationProvider(
        notifier: translationService,
        child: AnimatedBuilder(
          animation: translationService,
          builder: (context, child) {
            return MaterialApp(
              title: F.title,
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                Widget current = FToastBuilder()(context, child);
                return current;
              },
              navigatorKey: getIt<AppNavigator>().navigatorKey,
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(
                  seedColor: AppColors.primaryColor,
                ),
                canvasColor: Colors.transparent,
                useMaterial3: false,
                fontFamily: 'BeVietnamPro',
              ),
              locale: Locale(translationService.currentLanguageCode),
              home: const SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
