
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:map_pro/repository/notification_handler.dart';
import 'package:map_pro/repository/permission_handler.dart';
import 'package:map_pro/repository/firebe_repository.dart';
import 'package:map_pro/routes/app_routes.dart';
import 'package:map_pro/routes/multi_bloc_provider.dart';
import 'package:map_pro/utility/theme/app_color.dart';
import 'package:map_pro/utility/theme/text_styles.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async
{
  await Firebase.initializeApp();
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
   await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await requestNotificationPermissionSmartly();
  await FirebaseRepository.initFirebase();
  await NativeNotificationHandler.clearNotifications();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.primary,
    systemNavigationBarColor: AppColors.primary,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return CommonBlocProvider(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: '/',
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: 'My Task',
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              textStyle: TextStyles.boldText,
            ),
          ),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
