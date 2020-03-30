import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class TakePicturePage extends StatefulWidget {

  final CameraDescription camera;
  TakePicturePage({@required this.camera});

  @override
  State<StatefulWidget> createState() => _TakePicturePageState();
}
  
class _TakePicturePageState extends State<TakePicturePage> {
  
  CameraController _cameraController;
  Future<void> _initializeCameraControllerFuture;
  
  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeCameraControllerFuture = _cameraController.initialize();
  }

  void _takePicture(BuildContext context) async {
    try {
      await _initializeCameraControllerFuture;
      final path = join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
      await _cameraController.takePicture(path);
      Navigator.pop(context, path);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: <Widget>[
        FutureBuilder(
          future: _initializeCameraControllerFuture,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_cameraController);
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.bottomRight,
            child: Padding(padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(onPressed: () {
                  _takePicture(context);
                },
                backgroundColor: Colors.black,
                child: Icon(Icons.camera),
              ),),
          ),
        ),
      ],
    );
  }
}