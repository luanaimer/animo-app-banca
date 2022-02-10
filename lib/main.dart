import 'package:flutter/material.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:flutter_application_1/provider/atividade_repository.dart';
import 'package:flutter_application_1/provider/estatisticas_repository.dart';
import 'package:flutter_application_1/provider/humor_repository.dart';
import 'package:flutter_application_1/provider/trofeus_repository.dart';
import 'package:flutter_application_1/provider/usuario_repository.dart';
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
          create: (context) => TrofeusRepository(
            auth: context.read<AuthServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => HumoresRepository(
            auth: context.read<AuthServices>(),
            trofeus: context.read<TrofeusRepository>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => AtividadesRepository(
            auth: context.read<AuthServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => EstatisticasRepository(
            auth: context.read<AuthServices>(),
          ),
        ),
        ChangeNotifierProvider(
          create: (context) => UsuarioRepository(
            auth: context.read<AuthServices>(),
          ),
        ),
      ],
      child: MeuAplicativo(),
    ),
  );
}
