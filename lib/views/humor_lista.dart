import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/humor_item.dart';
import 'package:flutter_application_1/data/auth_services.dart';
import 'package:flutter_application_1/models/humor.dart';
import 'package:flutter_application_1/provider/humor_repository.dart';
import 'package:provider/provider.dart';

import 'humor_form.dart';

class HumorLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Humor> _lista = [];
    //final lista = context.read<HumoresRepository>().getList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de humores'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Humorform()),
              );
            },
            icon: Icon(Icons.add),
          ),
          IconButton(
            //onPressed: () => context.read<AuthServices>().logout(),

            icon: Icon(Icons.logout),
            onPressed: () {
              context.read<AuthServices>().logout();
              context.read<HumoresRepository>().clearData();
            },
          ),
        ],
      ),
      // body: ListView.separated(
      //     itemBuilder: (ctx, i) => HumorItem(_lista.elementAt((i))),
      //     padding: EdgeInsets.all(16),
      //     separatorBuilder: (_, __) => Divider(),
      //     itemCount: _lista.length));

      body: Container(
        color: Colors.indigo.withOpacity(0.05),
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(12.0),
        child: Consumer<HumoresRepository>(
          builder: (context, humores, child) {
            return humores.lista.isEmpty
                ? ListTile(
                    leading: Icon(Icons.star),
                    title: Text('Ainda não há registros de humor'),
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
    throw UnimplementedError();
  }
}
