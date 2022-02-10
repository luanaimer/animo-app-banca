import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DataItem extends StatelessWidget {
  final DateTime date;
  const DataItem(this.date);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("dd/MM");

    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          Container(
            height: 32,
            //color: Colors.purple,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey.shade300,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(dateFormat.format(date)),
            ),
          ),
        ],
      ),
    );
    throw UnimplementedError();
  }
}
