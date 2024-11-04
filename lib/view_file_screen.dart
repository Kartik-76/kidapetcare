// view_file_screen.dart
import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';

class ViewFileScreen extends StatefulWidget {
  final String filePath;

  const ViewFileScreen({super.key, required this.filePath});

  @override
  _ViewFileScreenState createState() => _ViewFileScreenState();
}

class _ViewFileScreenState extends State<ViewFileScreen> {
  late PdfControllerPinch _pdfController;

  @override
  void initState() {
    super.initState();
    _pdfController = PdfControllerPinch(
      document: PdfDocument.openFile(widget.filePath),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: PdfViewPinch(
        controller: _pdfController,
      ),
    );
  }
}