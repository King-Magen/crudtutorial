// import 'package:crudtutorial/utils/common_widgets/gradient_background.dart';
// import 'package:crudtutorial/values/app_strings.dart';
// import 'package:crudtutorial/values/app_theme.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Table')),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                  decoration:
                      BoxDecoration(color: Colors.white, border: Border.all()),
                  columns: const [
                    DataColumn(label: Text('REQUEST NO:')),
                    DataColumn(label: Text('NAME')),
                    DataColumn(label: Text('DESCRIPTION')),
                    DataColumn(label: Text('PREFERRED DATE')),
                    DataColumn(label: Text('EQUIPMENT')),
                    DataColumn(label: Text('DATE-SUBMIT')),
                    DataColumn(label: Text('STATUS')),
                  ],
                  rows: const [
                    DataRow(cells: [
                      DataCell(Text('11911')),
                      DataCell(Text('ROLIE ANINON')),
                      DataCell(Text('DILI NA MABUGNAW')),
                      DataCell(Text('FEBRUARY 5, 2025')),
                      DataCell(Text('KOENEG MACHINE')),
                      DataCell(Text('JANUARY 31, 2025')),
                      DataCell(Text('KOENEG PENDING')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('11912')),
                      DataCell(Text('ELAIZANEL VANO')),
                      DataCell(Text('INSTALLATION')),
                      DataCell(Text('FEBRUARY 10, 2025')),
                      DataCell(Text('MOTOR PUMP')),
                      DataCell(Text('FEBRUARY 02, 2025')),
                      DataCell(Text('APPROVED')),
                    ]),
                    DataRow(cells: [
                      DataCell(Text('11932')),
                      DataCell(Text('LOURENCE MARIE')),
                      DataCell(Text('REPAIR')),
                      DataCell(Text('FEBRUARY 26, 2025')),
                      DataCell(Text('CAKE CHILLER')),
                      DataCell(Text('FEBRUARY 16, 2025')),
                      DataCell(Text('IN-PROGRESS')),
                    ]),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
