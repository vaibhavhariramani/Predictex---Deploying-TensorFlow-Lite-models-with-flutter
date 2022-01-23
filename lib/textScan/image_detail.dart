import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'dart:ui';
import 'dart:async';
import 'package:flutter/services.dart';

class DetailScreen extends StatefulWidget {
  final String imagePath;
  DetailScreen(this.imagePath);

  @override
  _DetailScreenState createState() => new _DetailScreenState(imagePath);
}

class _DetailScreenState extends State<DetailScreen> {
  _DetailScreenState(this.path);

  final String path;

  Size _imageSize;
  List<TextElement> _elements = [];
  String recognizedText = "Loading ...";

  void _initializeVision() async {
    final File imageFile = File(path);

    if (imageFile != null) {
      await _getImageSize(imageFile);
    }

    final FirebaseVisionImage visionImage =
        FirebaseVisionImage.fromFile(imageFile);

    final TextRecognizer textRecognizer =
        FirebaseVision.instance.textRecognizer();

    final VisionText visionText =
        await textRecognizer.processImage(visionImage);

    String pattern = r".*";
    RegExp regEx = RegExp(pattern);

    String text = "";
    for (TextBlock block in visionText.blocks) {
      for (TextLine line in block.lines) {
        if (regEx.hasMatch(line.text)) {
          text += line.text + '\n';
          for (TextElement element in line.elements) {
            _elements.add(element);
          }
        }
      }
    }

    if (this.mounted) {
      setState(() {
        recognizedText = text;
      });
    }
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    final Image image = Image.file(imageFile);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  @override
  void initState() {
    _initializeVision();
    super.initState();
  }

  bool theme = true;
  Color mainColor = Color(0xFFE8FC40);
  Color blackk = Color(0xFF222222);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: theme ? Colors.black : Colors.blue,
        title: Text(
          "Image Details",
          style: TextStyle(
              color: theme ? mainColor : Colors.white, fontFamily: 'Valera'),
        ),
        actions: [
          IconButton(
            icon: Icon(theme ? Icons.wb_sunny : Icons.brightness_2,
                color: theme ? Colors.amberAccent : blackk),
            onPressed: () {
              setState(() {
                theme = !theme;
              });
            },
          ),
        ],
      ),
      body: _imageSize != null
          ? Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    width: double.maxFinite,
                    //color: theme ? Colors.black : Colors.white,
                    child: CustomPaint(
                      child: AspectRatio(
                        aspectRatio: _imageSize.aspectRatio,
                        child: Image.file(
                          File(path),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(16.0)),
                    color: theme ? Colors.black : Colors.white,
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Identified text",
                              style: TextStyle(
                                  color: theme ? mainColor : Colors.black,
                                  fontSize: 18,
                                  fontFamily: 'Valera'),
                            ),
                          ),
                          Divider(
                            color: theme ? Colors.white : Colors.black,
                            thickness: 0.5,
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.4,
                            width: MediaQuery.of(context).size.width,
                            child: SingleChildScrollView(
                              child: Text(
                                recognizedText,
                                style: TextStyle(
                                    color: theme ? Colors.white : Colors.black,
                                    fontFamily: 'Valera'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
      floatingActionButton: new FloatingActionButton(
        child: Icon(Icons.content_copy),
        backgroundColor: theme ? blackk : Colors.blue,
        foregroundColor: theme ? mainColor : Colors.white,
        onPressed: () {
          Clipboard.setData(new ClipboardData(text: recognizedText));
          Scaffold.of(context)
              .showSnackBar(SnackBar(content: Text('Text copied!')));
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
