import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/palette.dart';
import 'package:flutter_application_1/models/trofeu.dart';
import 'package:flutter_application_1/provider/trofeus_repository.dart';
import 'package:provider/src/provider.dart';

class Recompensas extends StatefulWidget {
  @override
  _RecompensasState createState() => _RecompensasState();
}

bool isLoading = false;
Trofeu trofeu = Trofeu(
    descobridor: 0, aplicado: [], determinado: [], escritor: 0, engajado: 0);

class _RecompensasState extends State<Recompensas> {
  _loadData() async {
    isLoading = true;
    await context.read<TrofeusRepository>().read();
    trofeu = context.read<TrofeusRepository>().trofeuUser;
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.kPrimaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Conquistas',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.indigo.withOpacity(0.05),
              child: Padding(
                  padding:
                      EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 12),
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: ListTile(
                              leading:
                                  Image.asset('assets/images/004-research.png'),

                              // CircleAvatar(
                              //     backgroundColor: Colors.grey.shade200,
                              //     backgroundImage: AssetImage(
                              //         'assets/images/004-research.png')),

                              title: Text('Descobridor'),
                              subtitle: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 12.0),
                                    child: Row(
                                      children: [
                                        Text('Você fez seu primeiro registro')
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        //margin: EdgeInsets.symmetric(vertical: 20),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                185,
                                        height: 16,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: LinearProgressIndicator(
                                            value: (trofeu.descobridor / 1),
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    (trofeu.descobridor > 0
                                                        ? Colors.green.shade500
                                                        : Colors
                                                            .yellow.shade800)),
                                            backgroundColor: Color(0xffD6D6D6),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 24)),
                                      Text('${trofeu.descobridor}/1')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: ListTile(
                              leading:
                                  Image.asset('assets/images/005-notes.png'),

                              //  CircleAvatar(
                              //     backgroundColor: Colors.grey.shade200,
                              //     backgroundImage: AssetImage(
                              //         'assets/images/005-notes.png')),

                              title: Text('Escritor'),
                              subtitle: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 12.0),
                                    child: Row(
                                      children: [
                                        Text('Você fez sua primeira anotação')
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        //margin: EdgeInsets.symmetric(vertical: 20),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                185,
                                        height: 16,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: LinearProgressIndicator(
                                            value: (trofeu.escritor / 1),
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    (trofeu.escritor == 1
                                                        ? Colors.green.shade500
                                                        : Colors
                                                            .yellow.shade800)),
                                            backgroundColor: Color(0xffD6D6D6),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 24)),
                                      Text('${trofeu.escritor}/1')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: ListTile(
                              leading: Image.asset(
                                  'assets/images/001-falling-star.png'),

                              // CircleAvatar(
                              //     backgroundColor: Colors.grey.shade200,
                              //     backgroundImage: AssetImage(
                              //         'assets/images/001-falling-star.png')),

                              title: Text('Engajado'),
                              subtitle: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 12.0),
                                    child: Row(
                                      children: [
                                        Text(
                                            'Você fez mais de um registro no mesmo dia')
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        //margin: EdgeInsets.symmetric(vertical: 20),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                185,
                                        height: 16,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: LinearProgressIndicator(
                                            value: (trofeu.engajado / 1),
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    (trofeu.engajado == 1
                                                        ? Colors.green.shade500
                                                        : Colors
                                                            .yellow.shade800)),
                                            backgroundColor: Color(0xffD6D6D6),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 24)),
                                      Text('${trofeu.engajado}/1')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: ListTile(
                              leading:
                                  Image.asset('assets/images/003-rocket.png'),

                              // CircleAvatar(
                              //     backgroundColor: Colors.grey.shade200,
                              //     backgroundImage: AssetImage(
                              //         'assets/images/003-rocket.png')),

                              title: Text('Aplicado'),
                              subtitle: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 12.0),
                                    child: Row(
                                      children: [
                                        Text(
                                            'Você registrou durante uma semana inteira')
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        //margin: EdgeInsets.symmetric(vertical: 20),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                185,
                                        height: 16,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: LinearProgressIndicator(
                                            value: (trofeu.aplicado.length / 7),
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                    (trofeu.aplicado.length == 7
                                                        ? Colors.green.shade500
                                                        : Colors
                                                            .yellow.shade800)),
                                            backgroundColor: Color(0xffD6D6D6),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 24)),
                                      Text('${trofeu.aplicado.length}/7')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16, bottom: 16),
                            child: ListTile(
                              leading:
                                  Image.asset('assets/images/002-flag.png'),

                              //  CircleAvatar(
                              //     backgroundColor: Colors.grey.shade200,
                              //     backgroundImage:
                              //         AssetImage('assets/images/002-flag.png')),

                              title: Text('Determinado'),
                              subtitle: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 8.0, bottom: 12.0),
                                    child: Row(
                                      children: [
                                        Text(
                                            'Você registrou durante 30 dias seguidos')
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        //margin: EdgeInsets.symmetric(vertical: 20),
                                        width:
                                            MediaQuery.of(context).size.width -
                                                185,
                                        height: 16,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          child: LinearProgressIndicator(
                                            value: (trofeu.determinado.length /
                                                30),
                                            valueColor: AlwaysStoppedAnimation<
                                                    Color>(
                                                (trofeu.determinado.length == 30
                                                    ? Colors.green.shade500
                                                    : Colors.yellow.shade800)),
                                            backgroundColor: Color(0xffD6D6D6),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.only(left: 24)),
                                      Text('${trofeu.determinado.length}/30')
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
    );
  }
}
