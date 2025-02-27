// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

Future<String> getPdfMetadata(String pdfUrl) async {
  try {
    // Download PDF to a temporary file
    final response = await http.get(Uri.parse(pdfUrl));
    if (response.statusCode != 200) return "Unknown PDF";

    final tempDir = await getTemporaryDirectory();
    final tempFile = File('${tempDir.path}/${pdfUrl.split('/').last}');
    await tempFile.writeAsBytes(response.bodyBytes);

    // Load the PDF document
    final PdfDocument document =
        PdfDocument(inputBytes: tempFile.readAsBytesSync());

    // Get the number of pages
    int pageCount = document.pages.count;

    // Get file size in MB
    String fileSize = formatFileSize(tempFile.lengthSync());

    // Dispose the document to release memory
    document.dispose();

    return "$pageCount Pages • PDF • $fileSize";
  } catch (e) {
    return "Error loading PDF";
  }
}

String formatFileSize(int bytes) {
  if (bytes < 1024) {
    return "$bytes B";
  } else if (bytes < 1024 * 1024) {
    return "${(bytes / 1024).toStringAsFixed(2)} KB";
  } else if (bytes < 1024 * 1024 * 1024) {
    return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
  } else {
    return "${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(2)} GB";
  }
}
