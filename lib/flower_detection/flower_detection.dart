import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class FlowerDetect extends StatefulWidget {
  @override
  _FlowerDetectState createState() => _FlowerDetectState();
}

class _FlowerDetectState extends State<FlowerDetect> {
  bool _loading = true;
  File _image;
  List _output;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }

  dectectImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 2,
        threshold: 0.6,
        imageMean: 127.5,
        imageStd: 127.5);
    setState(() {
      _output = output;
      _loading = false;
    });
  }

  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/flower_detection/model_unquant.tflite',
        labels: 'assets/flower_detection/labels.txt');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    dectectImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });

    dectectImage(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 50),
                const Text(
                  'Flowers  Recognizer',
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Signatra",
                  ),
                ),
                SizedBox(height: 5),
                const Text(
                  'Detects :',
                  style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      fontFamily: "Signatra"),
                ),
                Row(
                  children: const [
                    Text(
                      'Daisy,',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontFamily: "Signatra"),
                    ),
                    SizedBox(),
                    Text(
                      'Dandelion,',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontFamily: "Signatra"),
                    ),
                    SizedBox(),
                    Text(
                      'Rose,',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontFamily: "Signatra"),
                    ),
                    SizedBox(),
                    Text(
                      'Sunflower,',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontFamily: "Signatra"),
                    ),
                    SizedBox(),
                    Text(
                      'Tulip',
                      style: TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                          fontFamily: "Signatra"),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                Center(
                  child: _loading
                      ? Container(
                          width: 350,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                  'assets/flower_detection/flowers.png'),
                              const SizedBox(height: 50),
                            ],
                          ),
                        )
                      : Container(
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 250,
                                child: Image.file(_image),
                              ),
                              const SizedBox(height: 20),
                              _output != null
                                  ? Text(
                                      '${_output[0]['label']}',
                                      style: const TextStyle(
                                          color: Colors.black, fontSize: 16),
                                    )
                                  : Container(),
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox.fromSize(
                        size: Size(100, 100), // button width and height
                        child: ClipOval(
                          child: Material(
                            color: Colors.orange, // button color
                            child: InkWell(
                              splashColor: Colors.green, // splash color
                              onTap: () {
                                pickImage();
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.camera_alt,
                                    size: 40,
                                  ), // icon
                                  Text("Camera"), // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 25),
                      SizedBox.fromSize(
                        size: const Size(100, 100), // button width and height
                        child: ClipOval(
                          child: Material(
                            color: Colors.orange, // button color
                            child: InkWell(
                              splashColor: Colors.green, // splash color
                              onTap: () {
                                pickGalleryImage();
                              }, // button pressed
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const <Widget>[
                                  Icon(
                                    Icons.photo,
                                    size: 40,
                                  ), // icon
                                  Text("Gallery"), // text
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }
}
