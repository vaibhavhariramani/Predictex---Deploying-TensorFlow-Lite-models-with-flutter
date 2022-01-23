import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart'
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
          RaisedButton(
            onPressed: _read,
            child: Text('Start Scanning'),
          ),
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
