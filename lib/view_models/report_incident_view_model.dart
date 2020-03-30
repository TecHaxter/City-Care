import 'package:city_care/models/incident.dart';
import 'package:city_care/services/webservice.dart';
import 'package:flutter/cupertino.dart';

class ReportIncidentViewModel extends ChangeNotifier{
  String title;
  String description;
  String imagePath;

  Future<void> saveIncident() async {
    final Incident incident = new Incident(title: title, description: description, imageURL: imagePath);
    await WebService().saveIncident(incident);
    notifyListeners();
  }
}