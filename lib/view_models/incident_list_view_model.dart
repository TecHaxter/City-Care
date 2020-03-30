import 'package:city_care/services/webservice.dart';
import 'package:city_care/view_models/incident_view_model.dart';
import 'package:flutter/cupertino.dart';

enum Status {
  loading,
  empty,
  success
}

class IncidentListViewModel extends ChangeNotifier{

  List<IncidentViewModel> incidents = List<IncidentViewModel>();
  Status status = Status.empty;

  Future<void> getAllIncidents() async {
    status = Status.loading;
    final results = await WebService().getAllIncidents();
    incidents = results.map((incident) => IncidentViewModel(incident: incident)).toList();
    status = incidents.isEmpty ? Status.empty : Status.success;
    notifyListeners();
  }
}