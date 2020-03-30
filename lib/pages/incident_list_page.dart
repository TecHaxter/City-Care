import 'package:city_care/pages/inicident_report_page.dart';
import 'package:city_care/services/webservice.dart';
import 'package:city_care/view_models/incident_list_view_model.dart';
import 'package:city_care/view_models/report_incident_view_model.dart';
import 'package:city_care/widgets/incident_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IncidentListPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _IncidentListPageState();
}

class _IncidentListPageState extends State<IncidentListPage> {

  @override
  void initState() {
    super.initState();
    _populateAllIncidents();
  }

  void _populateAllIncidents() {
    Provider.of<IncidentListViewModel>(context, listen: false).getAllIncidents();
  }

  Future<void> _navigateToReportIncidentReportPage(BuildContext context) async {
    await Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => 
          ChangeNotifierProvider(
            create: (context) => ReportIncidentViewModel(),
            child: IncidentReportPage(),
          ),
        fullscreenDialog: true
      ));

    _populateAllIncidents();
  }

  Widget _updateUI(IncidentListViewModel vm) {
    switch(vm.status) {
      case Status.loading:
        return Center(child: CircularProgressIndicator());
      case Status.empty:
        return Center(child: Text("No Incidents Found !!"));
      case Status.success:
        return IncidentList(incidents: vm.incidents);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<IncidentListViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Incidents"),
        backgroundColor: Colors.green,
      ),
      body: _updateUI(vm),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _navigateToReportIncidentReportPage(context);
        },
      ),
    );
  }
}