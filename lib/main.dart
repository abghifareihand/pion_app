import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:pion_app/core/services/fcm_service.dart';
import 'package:pion_app/features/auth/splash/splash_view.dart';
import 'package:pion_app/firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:pion_app/provider_setup.dart';
import 'package:pion_app/ui/theme/app_colors.dart';
import 'package:pion_app/ui/theme/app_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initial env
  await dotenv.load(fileName: '.env');

  // Inital no screenshot
  await NoScreenshot.instance.screenshotOff();

  // Initial Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initial Notification
  await FcmService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SP PION App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.primary,
          ),
          scaffoldBackgroundColor: AppColors.background,
          bottomSheetTheme: BottomSheetThemeData(
            backgroundColor: AppColors.white,
          ),
          dialogTheme: const DialogTheme(elevation: 0),
          useMaterial3: true,
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: AppColors.primary,
            surfaceTintColor: AppColors.primary,
            foregroundColor: AppColors.white,
            titleTextStyle: AppFonts.medium.copyWith(
              color: AppColors.white,
              fontSize: 16,
            ),
            centerTitle: true,
          ),
          snackBarTheme: SnackBarThemeData(
            contentTextStyle: const TextStyle(color: AppColors.white),
            behavior: SnackBarBehavior.floating,
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            },
          ),
        ),
        supportedLocales: const <Locale>[Locale('id')],
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: SplashView(),
      ),
    );
  }
}
