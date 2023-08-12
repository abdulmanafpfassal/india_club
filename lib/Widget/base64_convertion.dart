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
  Image? image;

  @override
  void initState() {
    super.initState();
    _decodeImage();
  }

  void _decodeImage() {
    try {
      final uri = Uri.parse(widget.base64Url);
      final mimeType = uri.data!.mimeType;
      final base64Content = uri.data!.contentAsBytes();

      if (mimeType != null && base64Content.isNotEmpty) {
        setState(() {
          image = Image.memory(Uint8List.fromList(base64Content));
        });
      } else {
        print('Invalid data URI format');
      }
    } catch (e) {
      print('Error decoding image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: image ?? CircularProgressIndicator(color: Colors.orange,),
    );
  }
}

