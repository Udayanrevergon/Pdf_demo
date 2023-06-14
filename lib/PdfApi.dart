import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:rev_pdf/save_launch.dart';

class PageoneData {
  final String attribute;
  final String value;
  PageoneData({required this.attribute, required this.value});
}

class PdfApi {
  static Future<File> createDocument() async {
    print("I am here3");
    // final imageSvg = await rootBundle.loadString('assets/images/image1.svg');
    final imagejpeg = (await rootBundle.load('assets/images/image.jpeg'))
        .buffer
        .asUint8List();
    final centreImage =
        (await rootBundle.load('assets/images/revergon_image.jpeg'))
            .buffer
            .asUint8List();

    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        pageTheme: pw.PageTheme(margin: pw.EdgeInsets.all(0)),
        build: (context) => [
              pw.Container(
                  width: double.infinity,
                  height: 840,
                  child: pw.Stack(alignment: pw.Alignment.center, children: [
                    pw.Positioned(
                      top: 5,
                      child: pw.Image(pw.MemoryImage(imagejpeg),
                          height: 800, width: 600),
                    ),
                    pw.Positioned(
                      bottom: 450,
                      child: pw.Image(pw.MemoryImage(centreImage),
                          height: 350, width: 400),
                    ),
                    pw.Positioned(
                      bottom: 415,
                      child: pw.Row(
                        children: [
                          pw.Text("WORKSTATION ",
                              style: pw.TextStyle(
                                color: PdfColors.grey700,
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Text("Assessment ",
                              style: pw.TextStyle(
                                  fontSize: 20, color: PdfColors.grey700)),
                          pw.Text("Report ",
                              style: pw.TextStyle(
                                  fontSize: 20, color: PdfColors.grey700)),
                        ],
                      ),
                    ),
                    pw.Positioned(
                      bottom: 300,
                      child: pw.Container(
                        width: 300,
                        height: 500,
                        child: pw.TableHelper.fromTextArray(
                          headers: [],
                          cellStyle: const pw.TextStyle(fontSize: 12),
                          cellAlignment: pw.Alignment.topLeft,
                          context: context,
                          data: const <List<String>>[
                            // <String>['Date', 'PDF Version', 'Acrobat Version'],
                            <String>['Patient Name', 'TTTTT'],
                            <String>['Organization', 'IBM'],
                            <String>['Date', '14-06-23'],
                            <String>['Place', 'Bangalore'],
                            // <String>['1999', 'PDF 1.3'],
                          ],
                        ),
                      ),
                    ),
                  ])),
            ]));
    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }
}
