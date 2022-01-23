import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:predictex/main.dart';
import 'package:tflite/tflite.dart';

class FaceDetectPage extends StatefulWidget {
  const FaceDetectPage({Key key}) : super(key: key);

  @override
  _FaceDetectPageState createState() => _FaceDetectPageState();
}

class _FaceDetectPageState extends State<FaceDetectPage> {
  CameraImage imgCamera;
  CameraController cameraController;
  bool isWorking = false;
  String result = "";

  initCamera() {
    cameraController = CameraController(cameras[0], ResolutionPreset.medium);

    cameraController.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imageFromStream,
                  runModelOnFrame(),
                }
            });
      });
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/face_mask_detection/model.tflite",
        labels: "assets/face_mask_detection/labels.txt");
  }

  runModelOnFrame() async {
    if (imgCamera != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imgCamera.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera.height,
        imageWidth: imgCamera.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 1,
        threshold: 0.1,
        asynch: true,
      );

      result = "";

      recognitions.forEach((response) {
        result += response["label"] + "\n";
      });

      setState(() {
        result;
      });

      isWorking = false;
    }
  }

  @override
  void initState() {
    super.initState();
    initCamera();
    loadModel();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: Center(
                child: Text(
                  result,
                  style: TextStyle(
                    backgroundColor: Colors.black54,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              Positioned(
                top: 0,
                left: 0,
                width: size.width,
                height: size.height - 100,
                child: Container(
                  height: size.height - 100,
                  child: (!cameraController.value.isInitialized)
                      ? Container()
                      : AspectRatio(
                          aspectRatio: cameraController.value.aspectRatio,
                          child: CameraPreview(cameraController),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
