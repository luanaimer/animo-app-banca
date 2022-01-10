import 'package:flutter/material.dart';
import 'package:flutter_application_1/data/auth_services.dart';
import 'package:flutter_application_1/provider/humor_repository.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'myapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthServices()),
        ChangeNotifierProvider(
          create: (context) => HumoresRepository(
            auth: context.read<AuthServices>(),
          ),
        ),
      ],
      child: MeuAplicativo(),
    ),
  );
}
