import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/humor_form.dart';
import 'package:flutter_application_1/views/home.dart';
import 'package:flutter_application_1/views/login_form.dart';
import 'package:flutter_application_1/views/signup_form.dart';
import 'package:flutter_application_1/widgets/auth_check.dart';
import 'package:flutter_application_1/config/palette.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MeuAplicativo extends StatelessWidget {
  const MeuAplicativo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animo',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        //Locale('en', ''), // English, no country code
        Locale('pt', ''), // Spanish, no country code
      ],
      theme: ThemeData(
        primarySwatch: Palette.kPrimaryColor,
      ),
      home: AuthCheck(),
    );
  }
}
