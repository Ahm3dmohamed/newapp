import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart'; // Adjust if needed
import 'package:news_app/core/theme/apptheme.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/modules/screens/home_screen.dart';
import 'package:news_app/modules/screens/settings.dart';
import 'package:news_app/providers/local_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: ChangeNotifierProvider(
        create: (context) => LocaleProvider(),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return MaterialApp(
      theme: Apptheme.lightThem,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('ar'),
        Locale('fr'),
      ],
      locale: localeProvider.locale,
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (_) => HomeScreen(),
        // NewsScreen.routeName: (_) => NewsScreen(),
        Settings.routeName: (_) => const Settings(),
      },
    );
  }
}
