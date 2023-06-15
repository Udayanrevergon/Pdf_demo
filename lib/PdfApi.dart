import 'dart:io';

import 'package:flutter/services.dart' show rootBundle;
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
    final leftjpeg = (await rootBundle.load('assets/images/left_image.jpeg'))
        .buffer
        .asUint8List();
    final rightjpeg = (await rootBundle.load('assets/images/right_image.jpeg'))
        .buffer
        .asUint8List();
    final centreImage =
        (await rootBundle.load('assets/images/revergon_image.png'))
            .buffer
            .asUint8List();

    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(
        pageTheme: const pw.PageTheme(margin: pw.EdgeInsets.all(0)),
        build: (context) => [
              pw.Container(
                  width: double.infinity,
                  height: 840,
                  child: pw.Stack(alignment: pw.Alignment.center, children: [
                    pw.Positioned(
                      top: 5,
                      left: 0,
                      child: pw.Image(pw.MemoryImage(leftjpeg),
                          height: 700, width: 120),
                    ),
                    pw.Positioned(
                      top: 5,
                      right: 0,
                      child: pw.Image(pw.MemoryImage(rightjpeg),
                          height: 700, width: 125),
                    ),
                    pw.Positioned(
                      bottom: 435,
                      child: pw.Image(pw.MemoryImage(centreImage),
                          height: 350, width: 420),
                    ),
                    pw.Positioned(
                      bottom: 320,
                      child: pw.Row(
                        children: [
                          pw.Text("WORKSTATION ",
                              style: pw.TextStyle(
                                color: PdfColors.grey700,
                                fontSize: 20,
                                fontWeight: pw.FontWeight.bold,
                              )),
                          pw.Text("Assessment ",
                              style: const pw.TextStyle(
                                  fontSize: 20, color: PdfColors.grey700)),
                          pw.Text("Report ",
                              style: const pw.TextStyle(
                                  fontSize: 20, color: PdfColors.grey700)),
                        ],
                      ),
                    ),
                    pw.Positioned(
                      bottom: 200,
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
                            <String>['Patient Name', 'Arohi'],
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
    pdf.addPage(
      pw.MultiPage(
          pageTheme: const pw.PageTheme(margin: pw.EdgeInsets.all(0)),
          build: (context) => [
                pw.Container(
                  width: double.infinity,
                  height: 840,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(48.0),
                    child: pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Personal Details',
                                style: const pw.TextStyle(
                                  fontSize: 28,
                                )),
                            pw.SizedBox(
                              width: 100,
                              child: pw.Image(
                                pw.MemoryImage(centreImage),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 70,
                        ),
                        pw.TableHelper.fromTextArray(
                          headers: [],
                          cellStyle: const pw.TextStyle(fontSize: 14),
                          cellAlignment: pw.Alignment.topLeft,
                          context: context,
                          data: const <List<String>>[
                            // <String>['Date', 'PDF Version', 'Acrobat Version'],
                            <String>['Patient Name', 'Arohi'],
                            <String>['Age Band', '20-30'],
                            <String>['Gender', 'Female'],
                            <String>['Height', '172cm'],
                            <String>['Weight', '75kg'],
                            <String>['Function', 'Laptop'],
                            <String>['Screentime', '8-12 Hours'],
                            <String>['Mode Of Work', 'On-Site'],
                            // <String>['1999', 'PDF 1.3'],
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
    );
    pdf.addPage(
      pw.MultiPage(
          pageTheme: const pw.PageTheme(margin: pw.EdgeInsets.all(0)),
          build: (context) => [
                pw.Container(
                  width: double.infinity,
                  height: 840,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(48.0),
                    child: pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Key Findings & Outcomes',
                                style: const pw.TextStyle(
                                  fontSize: 28,
                                )),
                            pw.SizedBox(
                              width: 100,
                              child: pw.Image(
                                pw.MemoryImage(centreImage),
                              ),
                            ),
                          ],
                        ),
                        pw.SizedBox(
                          height: 70,
                        ),
                        pw.Header(
                          level: 0,
                          child: pw.Text('Key Findings',
                              style: const pw.TextStyle(
                                fontSize: 20,
                              )),
                        ),
                        pw.Padding(padding: const pw.EdgeInsets.all(10)),
                        pw.Column(
                          children: [
                            pw.ListView.builder(
                              itemBuilder: (context, index) {
                                return pw.Bullet(
                                  text: 'Finding ${index + 1}',
                                  style: const pw.TextStyle(
                                    fontSize: 16,
                                  ),
                                );
                              },
                              itemCount: 7,
                            ),
                          ],
                        ),
                        pw.Padding(padding: const pw.EdgeInsets.all(10)),
                        pw.Header(
                          level: 0,
                          child: pw.Text('Outcome/Resulting Pain Points',
                              style: const pw.TextStyle(
                                fontSize: 20,
                              )),
                        ),
                        pw.Padding(padding: const pw.EdgeInsets.all(10)),
                        pw.Column(
                          children: [
                            pw.ListView.builder(
                              itemBuilder: (context, index) {
                                return pw.Bullet(
                                  text: 'Pain Result ${index + 1}',
                                  style: const pw.TextStyle(
                                    fontSize: 16,
                                  ),
                                );
                              },
                              itemCount: 6,
                            ),
                          ],
                        ),
                        pw.Padding(padding: const pw.EdgeInsets.all(10)),
                      ],
                    ),
                  ),
                ),
              ]),
    );
    pdf.addPage(
      pw.MultiPage(
          pageTheme: const pw.PageTheme(margin: pw.EdgeInsets.all(0)),
          build: (context) => [
                pw.Container(
                  width: double.infinity,
                  height: 840,
                  child: pw.Padding(
                    padding: const pw.EdgeInsets.all(48.0),
                    child: pw.Column(
                      children: [
                        pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: [
                            pw.Text('Recommendations',
                                style: const pw.TextStyle(
                                  fontSize: 28,
                                )),
                            pw.SizedBox(
                              width: 100,
                              child: pw.Image(
                                pw.MemoryImage(centreImage),
                              ),
                            ),
                          ],
                        ),
                        // pw.SizedBox(
                        //   height: 70,
                        // ),
                        pw.Column(
                          children: [
                            pw.ListView.builder(
                              itemBuilder: (context, index) {
                                return pw.Bullet(
                                  text: 'Recommendation ${index + 1}',
                                  style: const pw.TextStyle(
                                    fontSize: 16,
                                  ),
                                );
                              },
                              itemCount: 7,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
    );
    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }
}
