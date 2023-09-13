import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision_2/flutter_mobile_vision_2.dart'
    show FlutterMobileVision, OcrText;

class OCR1 extends StatefulWidget {
  @override
  _OCR1State createState() => _OCR1State();
}

class _OCR1State extends State<OCR1> {
  int _cameraOcr = FlutterMobileVision.CAMERA_BACK;
  String _textValue = "sample";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Vaibhav\'\s OCR Reader'),
      ),
      body: Center(
          child: ListView(
        children: <Widget>[
          Text(_textValue),
          ElevatedButton(
              // elevation: 0,

              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Start Scanning',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                _read;
              })
          // RaisedButton(
          //   onPressed: _read,
          //   child: Text('Start Scanning'),
          // ),
        ],
      )),
    );
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _cameraOcr,
        waitTap: true,
      );

      setState(() {
        _textValue = texts[0].value;
      });
    } on Exception {
      texts.add(OcrText('Failed to recognize text.'));
    }
  }
}
