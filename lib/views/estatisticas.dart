import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/appIcons.dart';
import 'package:flutter_application_1/components/atividade_icon.dart';
import 'package:flutter_application_1/components/humor_item.dart';
import 'package:flutter_application_1/config/palette.dart';
import 'package:flutter_application_1/models/atividade_estatistica.dart';
import 'package:flutter_application_1/models/estatistica.dart';
import 'package:flutter_application_1/provider/atividade_repository.dart';
import 'package:flutter_application_1/provider/estatisticas_repository.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Estatisticas extends StatefulWidget {
  @override
  _EstatisticasState createState() => _EstatisticasState();
}

DateTime selectedDate = DateTime.now();
DateFormat formatter = DateFormat('yyyy-MM-dd');

class _EstatisticasState extends State<Estatisticas> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 1),
        lastDate: DateTime(2111));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        context.read<EstatisticasRepository>().dataRegistro = selectedDate;
        getChartData();
      });
  }

  Future<Null> _selectNextDate(BuildContext context) async {
    setState(() {
      selectedDate = selectedDate.add(const Duration(days: 1));
      context.read<EstatisticasRepository>().dataRegistro = selectedDate;
      getChartData();
    });
  }

  Future<Null> _selectPriorDate(BuildContext context) async {
    setState(() {
      selectedDate = selectedDate.subtract(const Duration(days: 1));
      context.read<EstatisticasRepository>().dataRegistro = selectedDate;
      getChartData();
    });
  }

  bool _isLoading = true;
  List<Estatistica> _charHumortData = [];
  List<AtividadeEstatistica> _charAtividadetData = [];
  int atividadeIndex = 1;
  int qtd = 1;
  String _legenda = '1 - 1';
  var formatter = NumberFormat("###.0", "en_US");

  void getChartData() async {
    await context.read<EstatisticasRepository>().returnEstatisticas();
    await context.read<EstatisticasRepository>().returnMediaAtividade();
    _charHumortData = context.read<EstatisticasRepository>().lista;
    setState(() {
      _isLoading = false;
    });
  }

  AtividadeIcon atividadeIcon = AtividadeIcon();

  @override
  void initState() {
    getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.kPrimaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          title: GestureDetector(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      _selectPriorDate(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios, size: 16)),
                Text(
                  DateFormat("EEEE, d 'de' MMM", "pt_BR").format(selectedDate),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w900,
                    //color: Palette.kGreyColor.shade500,
                    //color: Palette.kPrimaryColor.shade600,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      _selectNextDate(context);
                    },
                    icon: const Icon(Icons.arrow_forward_ios, size: 16)),
              ],
            ),
            onTap: () {
              _selectDate(context);
            },
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: _isLoading
              ? const Center(
                  child: const CircularProgressIndicator(strokeWidth: 5))
              : Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 24, bottom: 0),
                      // ignore: unnecessary_const
                      child: const Text(
                        'Variação de humor',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 8, bottom: 8, left: 62, right: 62),
                      // ignore: unnecessary_const
                      child: const Text(
                        'Média do dia e variação de humor nessa semana',
                        style: TextStyle(
                          fontSize: 14,
                          //fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 206,
                          width: 16,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 4, top: 4, bottom: 27),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.green.shade800),
                                  height: 12,
                                  //color: Colors.green.shade800,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 27, left: 4),
                                child: Container(
                                  height: 12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.yellow.shade800),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 27, left: 4),
                                child: Container(
                                  height: 12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.blue.shade800),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 27, left: 4),
                                child: Container(
                                  height: 12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.orange.shade800),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 4),
                                child: Container(
                                  height: 12,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.red.shade800),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width - 16,
                          //color: Colors.red,
                          child: SfCartesianChart(
                              primaryXAxis: DateTimeAxis(
                                labelStyle: const TextStyle(fontSize: 12),
                                edgeLabelPlacement: EdgeLabelPlacement.shift,
                                dateFormat: DateFormat("dd/MM"),
                              ),
                              // labelFormat: '{value}'),
                              primaryYAxis: NumericAxis(
                                // labelFormat: ' ',

                                minimum: 1,
                                maximum: 5,
                                interval: 1,
                              ),
                              series: <ChartSeries>[
                                LineSeries<Estatistica, DateTime>(
                                    dataSource: _charHumortData,
                                    // Dash values for spline
                                    xValueMapper:
                                        (Estatistica estatisticas, _) =>
                                            estatisticas.dia,
                                    yValueMapper:
                                        (Estatistica estatisticas, _) =>
                                            estatisticas.mediaSentimento)
                              ]),
                        ),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 24, bottom: 0),
                      child: Text(
                        'Humor e atividade',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          top: 8, bottom: 8, left: 46, right: 46),
                      child: Text(
                        'Humor médio de cada atividade',
                        style: const TextStyle(
                          fontSize: 16,
                          //fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    (context
                            .read<EstatisticasRepository>()
                            .listaMediaAtividade
                            .isEmpty)
                        ? Container(
                            child: ListTile(
                            title: Padding(
                              padding: const EdgeInsets.all(24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.error),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Nenhum dado disponível'),
                                  ),
                                ],
                              ),
                            ),
                          ))
                        : Container(
                            height: context
                                    .read<EstatisticasRepository>()
                                    .listaMediaAtividade
                                    .length *
                                88,
                            child: Consumer<EstatisticasRepository>(
                                builder: (context, estatistica, child) {
                              return ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    estatistica.listaMediaAtividade.length,
                                itemBuilder: (_, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: SizedBox(
                                      height: 80,
                                      child: ListTile(
                                        leading: Icon(
                                          estatistica.listaMediaAtividade[index]
                                              .atividade.iconData,
                                        ),
                                        title: Row(
                                          children: [
                                            // Icon(estatistica
                                            //     .listaMediaAtividade[index]
                                            //     ),
                                            Text(estatistica
                                                .listaMediaAtividade[index]
                                                .atividade
                                                .titulo),
                                          ],
                                        ),
                                        subtitle: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8, bottom: 8, right: 8),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width -
                                                    185,
                                                height: 16,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  child:
                                                      LinearProgressIndicator(
                                                    value: (estatistica
                                                            .listaMediaAtividade[
                                                                index]
                                                            .notaMedia /
                                                        5.toDouble()),
                                                    valueColor:
                                                        AlwaysStoppedAnimation<
                                                                Color>(
                                                            Palette
                                                                .kPrimaryColor),
                                                    backgroundColor:
                                                        Color(0xffD6D6D6),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 16),
                                                child: Text(
                                                    '${formatter.format(estatistica.listaMediaAtividade[index].notaMedia).toString()}/5.0'),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }),
                          ),

                    // Container(
                    //     height: 200,
                    //     width: MediaQuery.of(context).size.width - 16,
                    //     //color: Colors.red,
                    //     child: _buildUpdateDataSourceChart()),
                    // Container(
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Padding(
                    //         padding: const EdgeInsets.only(
                    //             left: 20, right: 20),
                    //         child: IconButton(
                    //             onPressed: () {
                    //               getChartPrior();
                    //             },
                    //             icon: Icon(Icons
                    //                 .keyboard_arrow_left_outlined)),
                    //       ),
                    //       Text(_legenda),
                    //       Padding(
                    //         padding: const EdgeInsets.only(
                    //             left: 20, right: 20),
                    //         child: IconButton(
                    //             onPressed: () {
                    //               getChartNext();
                    //             },
                    //             icon: Icon(Icons
                    //                 .keyboard_arrow_right_outlined)),
                    //       )
                    //     ],
                    //   ),
                  ],
                ),
        ));
  }
}
