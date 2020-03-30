import 'dart:io';
import 'package:city_care/models/incident.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

class WebService {

  Future<void> saveIncident(Incident incident) async {
    File file = File(incident.imageURL);
    final filename = basename(file.path.replaceAll(" ", ""));
    final url = "https://vast-savannah-75068.herokuapp.com/incidents";
    FormData formData = FormData.fromMap({
      "title": incident.title,
      "description": incident.description,
      "image": await MultipartFile.fromFile(incident.imageURL, filename: filename)
    });
    await Dio().post(
      url,
      data: formData,
      // options: Options(contentType: "application/x-www-form-urlencoded")
    );
  }

  Future<List<Incident>> getAllIncidents() async {
    final url = "https://vast-savannah-75068.herokuapp.com/incidents";
    final response = await Dio().get(url);
    if(response.statusCode == 200) {
      final Iterable json = response.data;
      return json.map((incident) => Incident.fromJson(incident)).toList();
    } else {
      throw Exception("Error");
    }
  }

}