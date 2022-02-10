import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/palette.dart';
import 'package:flutter_application_1/views/estatisticas.dart';
import 'package:flutter_application_1/views/animacao_conquista.dart';
import 'package:flutter_application_1/views/registros.dart';
import 'package:flutter_application_1/views/humor_form.dart';
import 'package:flutter_application_1/views/perfil.dart';
import 'package:flutter_application_1/views/recompensas.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

bool isLoading = false;

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final _tabs = [
    Registros(),
    Estatisticas(),
    Humorform(),
    Recompensas(),
    Perfil()
  ];

  Future<void> _onItemTapped(int index) async {
    if (index != 2) {
      setState(() {
        _currentIndex = index;
      });
    } else {
      _currentIndex = 0;
      bool result = false;
      result = await Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Humorform()));

      if (result) {
        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => Recompensa()));
        setState(() {
          _currentIndex = 3;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Palette.kPrimaryColor,
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.view_agenda),
              label: 'Registros',
              backgroundColor: Palette.kPrimaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.timeline),
              label: 'Estatísticas',
              backgroundColor: Palette.kPrimaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.add_reaction),
              label: 'Novo',
              backgroundColor: Palette.kPrimaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Conquistas',
              backgroundColor: Palette.kPrimaryColor),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
              backgroundColor: Palette.kPrimaryColor)
        ],
        onTap: (index) {
          setState(() {
            _onItemTapped(index);
          });
        },
      ),
    );
  }
}
