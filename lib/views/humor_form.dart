import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/config/palette.dart';
import 'package:flutter_application_1/views/animacao_conquista.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/atividades_card.dart';
import 'package:flutter_application_1/data/constants.dart';
import 'package:flutter_application_1/models/humor.dart';
import 'package:flutter_application_1/provider/humor_repository.dart';
import 'package:flutter_application_1/components/humor_lista.dart';
import 'package:provider/provider.dart';

class Humorform extends StatefulWidget {
  @override
  _HumorFormState createState() => _HumorFormState();
}

String _selectedItem = cNeutro;
List<String> _listaAtividadesSelecionadas = [];

class _HumorFormState extends State<Humorform> {
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  final Map<String, String> _formData = {};
  DateTime now = new DateTime.now();
  DateTime selectedDate = DateTime.now();
  // TimeOfDay selectedTime = TimeOfDay.fromDateTime(DateTime.now());

  @override
  void initState() {
    super.initState();

    // if (ModalRoute.of(context)!.settings.arguments != null) {
    //   final Humor humor = ModalRoute.of(context)!.settings.arguments as Humor;
    //   _loadFormData(humor);
    // } else {
    //   _resetFormData();
    // }

    Future.delayed(Duration.zero, () {
      setState(() {
        if (ModalRoute.of(context)!.settings.arguments != null) {
          final Humor humor =
              ModalRoute.of(context)!.settings.arguments as Humor;
          _loadFormData(humor);
        } else {
          _resetFormData();
        }
      });
    });
  }

  @override
  void _loadFormData(Humor humor) {
    if (humor != null) {
      _formData['id'] = humor.id ?? "";
      _selectedItem = humor.sentimento;

      _listaAtividadesSelecionadas.clear();

      humor.atividades?.forEach((atividade) {
        _listaAtividadesSelecionadas.add(atividade);
      });

      //_listaAtividadesSelecionadas = humor.atividades;
      _formData['anotacao'] = humor.anotacao ?? "";

      selectedDate = humor.data.toDate();
    }
  }

  void _resetFormData() {
    _selectedItem = cNeutro;
    _listaAtividadesSelecionadas.clear();
    _formData['anotacao'] = '';
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 1),
        lastDate: DateTime(2111));
    if (picked != null)
      setState(() {
        selectedDate = new DateTime(picked.year, picked.month, picked.day,
            selectedDate.hour, selectedDate.minute);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: TimeOfDay.fromDateTime(selectedDate));
    if (picked != null) {
      setState(() {
        DateTime newselectedDate = new DateTime(selectedDate.year,
            selectedDate.month, selectedDate.day, picked.hour, picked.minute);
        selectedDate = newselectedDate;
      });
    }
  }

  Widget build(BuildContext context) {
    // if (ModalRoute.of(context)!.settings.arguments != null) {
    //   final Humor humor = ModalRoute.of(context)!.settings.arguments as Humor;
    //   _loadFormData(humor);
    // } else {
    //   _resetFormData();
    // }

    late HumoresRepository humorRespository =
        Provider.of<HumoresRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.close)),
          automaticallyImplyLeading: false,
          title: GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  icon: Icon(Icons.calendar_today),
                  iconSize: 16,
                ),
                Text(
                  // DateFormat.yMMMMd().format(selectedDate),
                  DateFormat("d 'de' MMMM, y", "pt_BR").format(selectedDate),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            onTap: () {
              _selectDate(context);
            },
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () async {
                  final isValid = _form.currentState!.validate();
                  if (isValid) {
                    _form.currentState!.save();

                    setState(() {
                      _isLoading = true;
                    });

                    DateTime date = new DateTime(now.year, now.month, now.day,
                        now.hour, now.minute, now.second);

                    DateFormat formatter = DateFormat.yMMMMd();

                    int _sentimentoNota = 0;
                    switch (_selectedItem) {
                      case cMuitoMal:
                        _sentimentoNota = 1;
                        break;
                      case cMal:
                        _sentimentoNota = 2;
                        break;
                      case cNeutro:
                        _sentimentoNota = 3;
                        break;
                      case cFeliz:
                        _sentimentoNota = 4;
                        break;
                      case cRadiante:
                        _sentimentoNota = 5;
                        break;
                      default:
                        break;
                    }

                    Humor humor = Humor(
                        id: _formData['id'],
                        sentimento: _selectedItem,
                        atividades: _listaAtividadesSelecionadas,
                        anotacao: _formData['anotacao'],
                        data: Timestamp.fromDate(selectedDate),
                        sentimentoNota: _sentimentoNota);

                    await humorRespository.save(humor);

                    if (humorRespository.novaRecompensa) {
                      Navigator.of(context).pop(true);
                    } else {
                      setState(() {
                        _isLoading = false;
                      });

                      Navigator.of(context).pop(false);
                    }
                  }
                },
                icon: Icon(Icons.done)),
          ]),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.indigo.withOpacity(0.05),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: Form(
                    key: _form,
                    child: Column(
                      children: <Widget>[
                        Container(
                          color: Palette.kPrimaryColor,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 12, right: 12, top: 8, bottom: 8),
                            child: GestureDetector(
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  Padding(padding: EdgeInsets.only(right: 4)),
                                  Text(
                                    DateFormat.Hm().format(selectedDate),
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                _selectTime(context);
                              },
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8, left: 12, right: 12, bottom: 8),
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Como você está se sentindo?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                HumorLista(
                                  selectedItem: (String selectedItem) {
                                    _selectedItem = selectedItem;
                                  },
                                  loadSelectedItem: _selectedItem,
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    'O que você fez hoje?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                    height:
                                        (MediaQuery.of(context).size.height) /
                                            2,
                                    child: AtividadeCard(
                                        _listaAtividadesSelecionadas)),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, bottom: 8),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    'Quer colocar uma anotação?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: TextFormField(
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      //labelText: 'Senha',
                                    ),
                                    initialValue: _formData['anotacao'],
                                    //decoration: InputDecoration(labelText: 'Anotação'),
                                    onSaved: (value) =>
                                        _formData['anotacao'] = value!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
