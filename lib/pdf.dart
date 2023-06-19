import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:open_document/my_files/init.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:rev_pdf/PdfApi.dart';

class PdfGenerator extends StatefulWidget {
  const PdfGenerator({super.key});

  @override
  State<PdfGenerator> createState() => _PdfGeneratorState();
}

class _PdfGeneratorState extends State<PdfGenerator> {
  // @override
  // void initState() async {
  //   final info = await Printing.info();
  //   setState(() {
  //     printingInfo = info;
  //   });
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    Future<void> _saveAsFile(
      BuildContext context,
      LayoutCallback build,
      PdfPageFormat pageFormat,
    ) async {
      final bytes = await build(pageFormat);
      final dir = await getExternalStorageDirectory();
      final file = File('${dir!.path}/report.pdf');
      print('Save as file ${file.path} ...');
      await file.writeAsBytes(bytes);
      await OpenFile.open(file.path);
    }

    final actions = <PdfPreviewAction>[
      if (!kIsWeb)
        PdfPreviewAction(
          icon: const Icon(Icons.save),
          onPressed: _saveAsFile,
        )
    ];
    void _showPrintedToast(BuildContext context) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Document printed successfully'),
        ),
      );
    }

    void _showSharedToast(BuildContext context) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Document shared successfully'),
        ),
      );
    }

    return Scaffold(
      body: PdfPreview(
        maxPageWidth: 700,
        canChangePageFormat: false,
        canChangeOrientation: false,
        canDebug: false,
        build: (format) => PdfApi(context).generateDocument(format),
        actions: actions,
        onPrinted: _showPrintedToast,
        onShared: _showSharedToast,
      ),
      // body: Center(
      //   child: ElevatedButton(
      //     child: const Text('Create PDF'),
      //     onPressed: () async {
      //       print("I am here1");
      //       PdfApi(context);
      //       final pdfFile = await PdfApi(context).createDocument();
      //       openFile(pdfFile);
      //     },
      //   ),
      // ),
    );
  }
}
