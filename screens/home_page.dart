import 'package:flutter/material.dart';
import 'package:crudtutorial/api/users.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<List<String>> tableData = [];

  List<List<String>> convertToTableFormat(List<Map<String, dynamic>> data) {
    return data
        .map((map) => [
              map["idnumber"].toString(),
              map["name"].toString(),
              map["middlename"].toString(),
              map["lastname"].toString(),
              map["position"].toString(),
              map["address"].toString(),
              map["number"].toString(),
            ])
        .toList();
  }

  Future<void> fetchUsers() async {
    try {
      var users = await ApiService.getAllUsers();
      setState(() {
        tableData =
            convertToTableFormat(users); // ✅ Update state with fetched data
      });
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  void initializeControllers() {}

  void disposeControllers() {}

  void controllerListener() {}

  @override
  void initState() {
    initializeControllers();
    super.initState();
    fetchUsers();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold( 
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                    decoration: BoxDecoration(color: Colors.white, border: Border.all()),
                    columns: const [
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'ID NUMBER', 
                            style: TextStyle(
                              fontStyle: FontStyle.italic
                            )
                          )
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'NAME', 
                            style: TextStyle(
                              fontStyle: FontStyle.italic
                            )
                          )
                        ),
                      ), 
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'MIDDLENAME', 
                            style: TextStyle(
                              fontStyle: FontStyle.italic
                            )
                          )
                        ),
                      ), 
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'LASTNAME', 
                            style: TextStyle(
                              fontStyle: FontStyle.italic
                            )
                          )
                        ),
                      ), 
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'POSITION', 
                            style: TextStyle(
                              fontStyle: FontStyle.italic
                            )
                          )
                        ),
                      ), 
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'ADDRESS', 
                            style: TextStyle(
                              fontStyle: FontStyle.italic
                            )
                          )
                        ),
                      ), 
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'PHONE/MOBILE NUMBER', 
                            style: TextStyle(
                              fontStyle: FontStyle.italic
                            )
                          )
                        ),
                      ),  
                    ],
                    rows: tableData.map((row) {
                      return DataRow(
                        cells: row
                            .map((cell) => DataCell(Text(cell.toString())))
                            .toList(),
                      );
                    }).toList()),
              ),
            ),
          ),
        ));
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       appBar: AppBar(title: Text('User Table')),
  //       body: // main content
  //           ListView(padding: EdgeInsets.zero, children: [
  //         ElevatedButton(
  //           onPressed: ()async {
  //             String? jsonString = SharedPrefUtils.getString('data');
  //             List<dynamic> jsonData = jsonDecode(jsonString!);
  //             List<Map<String, dynamic>> users = List<Map<String, dynamic>>.from(jsonData);
  //             print(users);
  //             print(users[0]['idnumber']);
  //           },
  //           child: Text("Click Me"),
  //         ),
  //       ]));
  // }
}
