import 'dart:core';

import 'package:flutter/material.dart';
import 'package:rev_pdf/PdfApi.dart';
import 'package:rev_pdf/save_launch.dart';

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
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text('Create PDF'),
          onPressed: () async {
            print("I am here1");
            // PdfApi(context);
            final pdfFile = await PdfApi(context).createDocument();
            openFile(pdfFile);
          },
        ),
      ),
    );
  }
}
