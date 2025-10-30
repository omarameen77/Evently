import 'package:evently/core/theme/app_theme/theme_dark.dart';
import 'package:evently/core/theme/app_theme/theme_light.dart';
import 'package:evently/features/auth/login/login_screen.dart';
import 'package:evently/features/home/home_screen.dart';
import 'package:evently/generated/l10n.dart';
import 'package:evently/provider/auth_provider.dart';
import 'package:evently/provider/event_list_provider.dart';
import 'package:evently/provider/local_provider.dart';
import 'package:evently/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => LocaleProvider()),
        ChangeNotifierProvider(create: (_) => EventListProvider())
      ],
      child: const EventlyApp(),
    ),
  );
}

class EventlyApp extends StatelessWidget {
  const EventlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localeProvider = Provider.of<LocaleProvider>(context);

    final User? currentUser = FirebaseAuth.instance.currentUser;
    final Widget initialScreen =
        currentUser != null ? const HomeScreen() : const LoginScreen();

    return MaterialApp(
      locale: localeProvider.locale,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: initialScreen,
    );
  }
}
