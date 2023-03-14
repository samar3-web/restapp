import 'package:flutter/material.dart';
import 'package:restapp/adddatawidget.dart';
import 'package:restapp/caseslist.dart';
import 'package:restapp/models/cases.dart';
import 'dart:async';

import 'package:restapp/services/api_service.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService api = ApiService();
  late List<Cases> casesList;

  @override
  Widget build(BuildContext context) {
    casesList = [];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: FutureBuilder(
            future: loadList(),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData ) {
                return CasesList(cases: snapshot.data);
              } else {
                return Center(
                  child: Text(
                    'No data found, tap plus button to add!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                );
              }
            },
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }


  Future loadList() async {
    List<Cases> casesList = await api.getCases();
    print(casesList.toString());
    setState(() {
      this.casesList = casesList;
    });
    return casesList;
  }

  _navigateToAddScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataWidget()),
    );
  }
}