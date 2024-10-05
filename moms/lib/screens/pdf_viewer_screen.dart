import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
// import 'package:moms/screens/resources.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PDFViewerScreen extends StatefulWidget {
  final String filePath;

  const PDFViewerScreen({Key? key, required this.filePath}) : super(key: key);

  @override
  _PDFViewerScreenState createState() => _PDFViewerScreenState();
}

class _PDFViewerScreenState extends State<PDFViewerScreen> {
  String? localPath;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    // Load the PDF from the assets and save it locally
    final byteData = await rootBundle.load(widget.filePath);

    // Convert ByteData to Uint8List
    final buffer = byteData.buffer.asUint8List();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/pregnancy_guide.pdf');

    await file.writeAsBytes(buffer, flush: true);

    setState(() {
      localPath = file.path; // Set the local path to the PDF
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.navigate_before,
              color: Colors.white,
              size: 34,
            )),
        title: const Text(
          'Resources',
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        backgroundColor: Colors.purple,
        centerTitle: true,
      ),
      body: localPath == null // Show loading indicator until the file is ready
          ? Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: localPath,
            ),
    );
  }
}
