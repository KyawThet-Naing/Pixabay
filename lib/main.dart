import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pixabay/pages/pixabay.dart';
import 'package:pixabay/provider/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      path: 'assets/languages',
      supportedLocales: [
        Locale('en', 'US'),
        Locale('my', 'MM'),
      ],
      fallbackLocale: Locale('en', 'US'),
      child: ChangeNotifierProvider(
          create: (BuildContext context) => ThemeProvider(),
          child: EasyPixabay())));
}

class EasyPixabay extends StatelessWidget {
  const EasyPixabay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    themeProvider.checkTheme();
    return Consumer<ThemeProvider>(
        builder: (context, ThemeProvider tp, child) => MaterialApp(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
              themeMode: tp.themeMode,
              debugShowCheckedModeBanner: false,
              title: 'Easy Pixabay',
              theme: ThemeData(
                fontFamily:
                    context.locale.languageCode == 'en' ? 'CreteRound' : 'MM3',
                brightness: Brightness.light,
                primarySwatch: Colors.indigo,
              ),
              darkTheme: ThemeData(
                  fontFamily: context.locale.languageCode == 'en'
                      ? 'CreteRound'
                      : 'MM3',
                  iconTheme: IconThemeData(color: Colors.white),
                  brightness: Brightness.dark,
                  primarySwatch: Colors.teal,
                  primaryColor: Colors.teal),
              home: Pixabay(),
            ));
  }
}
