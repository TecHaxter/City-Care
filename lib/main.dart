import 'package:city_care/pages/incident_list_page.dart';
import 'package:city_care/view_models/incident_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChangeNotifierProvider(
        create: (context) => IncidentListViewModel(),
        child: IncidentListPage(),
      ),
    );
  }
}