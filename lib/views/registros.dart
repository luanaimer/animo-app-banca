import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/appIcons.dart';
import 'package:flutter_application_1/components/data_item.dart';
import 'package:flutter_application_1/components/humor_item.dart';
import 'package:flutter_application_1/config/palette.dart';
import 'package:flutter_application_1/models/humor.dart';
import 'package:flutter_application_1/provider/humor_repository.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:date_time_picker/date_time_picker.dart';

class Registros extends StatefulWidget {
  @override
  _RegistrosState createState() => _RegistrosState();
}

bool isLoading = false;
List<Humor> _listaHumores = [];
DateTime selectedDate = DateTime.now();
DateFormat formatter = DateFormat('yyyy-MM-dd');

class _RegistrosState extends State<Registros> {
  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 1),
        lastDate: DateTime(2111));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        context.read<HumoresRepository>().dataRegistro = selectedDate;
        context.read<HumoresRepository>().readHumores();
      });
  }

  Future<Null> _selectNextDate(BuildContext context) async {
    setState(() {
      selectedDate = selectedDate.add(Duration(days: 1));
      context.read<HumoresRepository>().dataRegistro = selectedDate;
      context.read<HumoresRepository>().readHumores();
    });
  }

  Future<Null> _selectPriorDate(BuildContext context) async {
    setState(() {
      selectedDate = selectedDate.subtract(Duration(days: 1));
      context.read<HumoresRepository>().dataRegistro = selectedDate;
      context.read<HumoresRepository>().readHumores();
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat format = new DateFormat("yyyy-MM-dd");
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
                  icon: Icon(Icons.arrow_back_ios, size: 16)),
              Text(
                DateFormat("EEEE, d 'de' MMM", "pt_BR").format(selectedDate),
                style: TextStyle(
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
                  icon: Icon(Icons.arrow_forward_ios, size: 16)),
            ],
          ),
          onTap: () {
            _selectDate(context);
          },
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
        child: Consumer<HumoresRepository>(
          builder: (context, humores, child) {
            return humores.lista.isEmpty
                ? ListTile(
                    leading: Icon(Icons.error),
                    title: Text('Ainda não há nenhum registro!'),
                  )
                : ListView.builder(
                    itemCount: humores.lista.length,
                    itemBuilder: (_, index) {
                      return HumorItem(humores.lista[index]);
                    },
                  );
          },
        ),
      ),
    );
  }
}
