import 'package:city_care/view_models/incident_view_model.dart';
import 'package:flutter/material.dart';

class IncidentList extends StatelessWidget {
  
  final List<IncidentViewModel> incidents;

  IncidentList({this.incidents});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      itemCount: incidents.length,
      itemBuilder: (context, index) {
        final incident = incidents[index];
        return ListTile(
          leading: Image.network("https://vast-savannah-75068.herokuapp.com${incident.imageURL}"),
          title: Text(incident.title),
          subtitle: Text(incident.description),
        );
      },
    );
  }
}