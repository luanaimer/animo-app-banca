import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/perfil_item.dart';
import 'package:flutter_application_1/config/palette.dart';
import 'package:flutter_application_1/provider/auth_services.dart';
import 'package:flutter_application_1/models/humor.dart';
import 'package:provider/src/provider.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

bool isLoading = false;
List<Humor> _listaHumores = [];

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.kPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Perfil',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: 3,
              itemBuilder: (context, index) {
                return PerfilItem(index);
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(24),
                child: GestureDetector(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      'Sair',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: Palette.kPrimaryColor),
                    ),
                  ),
                  onTap: () async {
                    try {
                      await context.read<AuthServices>().logout();

                      //await context.read<HumoresRepository>().readHumores();
                    } on AuthException catch (e) {
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(content: Text(e.message)));
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
