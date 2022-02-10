import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/palette.dart';
import 'package:flutter_application_1/views/home.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Recompensa extends StatefulWidget {
  const Recompensa({Key? key}) : super(key: key);

  @override
  _RecompensaState createState() => _RecompensaState();
}

class _RecompensaState extends State<Recompensa> {
  final nome = TextEditingController();
  final sobrenome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nova conquista desbloqueada!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.5,
                color: Palette.kPrimaryColor,
              ),
            ),
            Lottie.asset(
              'assets/images/award-badge.json',
              repeat: true,
              reverse: true,
              animate: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Visualizar conquistas',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
