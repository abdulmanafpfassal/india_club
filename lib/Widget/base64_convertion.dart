import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:typed_data';

class Base64ImageWidget extends StatefulWidget {
  final String base64Url;

  Base64ImageWidget({required this.base64Url});

  @override
  _Base64ImageWidgetState createState() => _Base64ImageWidgetState();
}

class _Base64ImageWidgetState extends State<Base64ImageWidget> {
  late Image image;

  @override
  void initState() {
    super.initState();
    _decodeImage();
  }

  void _decodeImage() {
    try {
      Uint8List imageBytes = base64Url.decode(widget.base64Url);
      setState(() {
        image = Image.memory(imageBytes);
      });
    } catch (e) {
      print('Error decoding image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: image ?? CircularProgressIndicator(),
    );
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Base64 Image Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Base64 Image Example'),
        ),
        body: Base64ImageWidget(
          base64Url: 'YOUR_BASE64_URL_HERE',
        ),
      ),
    );
  }
}
