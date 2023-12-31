import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:open_document/my_files/init.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class TakeContext {
  final BuildContext ctx;
  TakeContext(this.ctx);
}

final now = DateTime.now();
String formatter = DateFormat('y').format(now);

class PdfApi {
  BuildContext ctx;

  PdfApi(this.ctx);
  // Future<void> _saveAsFile(
  //   BuildContext context,
  //   LayoutCallback build,
  //   PdfPageFormat pageFormat,
  // ) async {
  //   final bytes = await build(pageFormat);

  //   final appDocDir = await getApplicationDocumentsDirectory();
  //   final appDocPath = appDocDir.path;
  //   final file = File('$appDocPath/document.pdf');
  //   print('Save as file ${file.path} ...');
  //   await file.writeAsBytes(bytes);
  //   await OpenFile.open(file.path);
  // }
  Future<Uint8List> generateDocument(PdfPageFormat format) async {
    var size = MediaQuery.of(ctx).size;

    final doc = pw.Document(pageMode: PdfPageMode.outlines);
    // Future<File> createDocument() async {
    print("I am here3");
    // final imageSvg = await rootBundle.loadString('assets/images/image1.svg');
    final leftjpeg = (await rootBundle.load('assets/images/left_image.jpeg'))
        .buffer
        .asUint8List();
    final rightjpeg = (await rootBundle.load('assets/images/right_image.jpeg'))
        .buffer
        .asUint8List();
    final revergonLogo =
        (await rootBundle.load('assets/images/revergon_image.png'))
            .buffer
            .asUint8List();
    final workstationImage =
        (await rootBundle.load('assets/images/workstation_image.png'))
            .buffer
            .asUint8List();
    final sideImage = (await rootBundle.load('assets/images/sideimage.png'))
        .buffer
        .asUint8List();

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        footer: (context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(
                bottom: 2 * PdfPageFormat.mm,
                left: 1.0 * PdfPageFormat.cm,
                right: 1.0 * PdfPageFormat.cm),
            child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Copyright © $formatter | Revergon Solutions Private Limited | All Rights Reserved.',
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(color: PdfColors.grey, fontSize: 6),
                  ),
                  pw.Text(
                    'Report ID: 9001_1048',
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(color: PdfColors.grey, fontSize: 6),
                  ),
                ]),
          );
        },
        pageTheme: const pw.PageTheme(
            pageFormat: PdfPageFormat.a4, margin: pw.EdgeInsets.all(0)),
        build: (context) => [
          pw.Container(
            width: double.infinity,
            height: size.height * 0.8,
            child: pw.Stack(
              alignment: pw.Alignment.center,
              children: [
                pw.Positioned(
                  top: size.height * 0.005,
                  left: 0,
                  child: pw.Image(pw.MemoryImage(leftjpeg),
                      height: size.height * 0.5, width: size.width * 0.28),
                ),
                pw.Positioned(
                  top: size.height * 0.005,
                  right: 0,
                  child: pw.Image(pw.MemoryImage(rightjpeg),
                      height: size.height * 0.5, width: size.width * 0.28),
                ),
                pw.Positioned(
                  bottom: size.height * 0.35,
                  child: pw.Image(pw.MemoryImage(revergonLogo),
                      height: size.height * 0.41, width: 420),
                ),
                pw.Positioned(
                  bottom: size.height * 0.27,
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
                  bottom: size.height * 0.15,
                  child: pw.Container(
                    width: size.width * 0.7,
                    height: size.height * 0.6,
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
                // pw.Positioned(
                //   bottom: 10,
                //   left: 10,
                //   child: pw.Container(
                //     alignment: pw.Alignment.centerRight,
                //     margin:
                //         const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
                //     child: pw.Text(
                //       'Copyright © $formatter | Revergon Solutions Private Limited | All Rights Reserved.',
                //       style: pw.Theme.of(context)
                //           .defaultTextStyle
                //           .copyWith(color: PdfColors.grey, fontSize: 6),
                //     ),
                //   ),
                // ),
                // pw.Positioned(
                //   bottom: 10,
                //   right: 10,
                //   child: pw.Container(
                //     alignment: pw.Alignment.centerRight,
                //     margin:
                //         const pw.EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
                //     child: pw.Text(
                //       'Report ID: 9001_1048',
                //       style: pw.Theme.of(context)
                //           .defaultTextStyle
                //           .copyWith(color: PdfColors.grey, fontSize: 6),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
    pdf.addPage(
      pw.MultiPage(
          footer: (context) {
            return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(
                  bottom: 2 * PdfPageFormat.mm,
                  left: 1.0 * PdfPageFormat.cm,
                  right: 1.0 * PdfPageFormat.cm),
              child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Copyright © $formatter | Revergon Solutions Private Limited | All Rights Reserved.',
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(color: PdfColors.grey, fontSize: 6),
                    ),
                    pw.Text(
                      'Report ID: 9001_1048',
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(color: PdfColors.grey, fontSize: 6),
                    ),
                  ]),
            );
          },
          pageTheme: const pw.PageTheme(
              pageFormat: PdfPageFormat.a4, margin: pw.EdgeInsets.all(0)),
          build: (context) => [
                pw.Container(
                  width: double.infinity,
                  height: size.height * 0.8,
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
                              width: size.width * 0.23,
                              child: pw.Image(
                                pw.MemoryImage(revergonLogo),
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
    pdf.addPage(pw.MultiPage(
        footer: (context) {
          return pw.Container(
            alignment: pw.Alignment.centerRight,
            margin: const pw.EdgeInsets.only(
                bottom: 2 * PdfPageFormat.mm,
                left: 1.0 * PdfPageFormat.cm,
                right: 1.0 * PdfPageFormat.cm),
            child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Copyright © $formatter | Revergon Solutions Private Limited | All Rights Reserved.',
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(color: PdfColors.grey, fontSize: 6),
                  ),
                  pw.Text(
                    'Report ID: 9001_1048',
                    style: pw.Theme.of(context)
                        .defaultTextStyle
                        .copyWith(color: PdfColors.grey, fontSize: 6),
                  ),
                ]),
          );
        },
        pageTheme: const pw.PageTheme(
          margin: pw.EdgeInsets.all(0),
          // buildBackground:  (context) => pw.MemoryImage(sideImage),
        ),
        build: (context) => [
              pw.Container(
                  width: double.infinity,
                  height: size.height * 0.8,
                  child: pw.Padding(
                      padding: const pw.EdgeInsets.all(48.0),
                      child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Text('Workstation',
                                    style: const pw.TextStyle(
                                      fontSize: 28,
                                    )),
                                pw.SizedBox(
                                  width: 100,
                                  child: pw.Image(
                                    pw.MemoryImage(revergonLogo),
                                  ),
                                ),
                              ],
                            ),
                            pw.SizedBox(
                              height: 30,
                            ),
                            pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 20),
                                child: pw.SizedBox(
                                  width: 700,
                                  height: 300,
                                  child: pw.Image(
                                    pw.MemoryImage(workstationImage),
                                  ),
                                )),
                            pw.SizedBox(
                              height: 50,
                            ),
                            pw.Padding(
                              padding: const pw.EdgeInsets.symmetric(
                                  horizontal: 20.0),
                              child: pw.Text("Current Workstation",
                                  style: const pw.TextStyle(fontSize: 25)),
                            ),
                            pw.SizedBox(height: 40),
                            pw.Column(
                              children: [
                                pw.Padding(
                                  padding: const pw.EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: pw.ListView.builder(
                                    itemBuilder: (context, index) {
                                      return pw.Bullet(
                                        text:
                                            'Workstation description ${index + 1}',
                                        style: const pw.TextStyle(
                                          fontSize: 16,
                                        ),
                                      );
                                    },
                                    itemCount: 4,
                                  ),
                                )
                              ],
                            ),
                          ])))
            ]));
    pdf.addPage(
      pw.MultiPage(
          footer: (context) {
            return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(
                  bottom: 2 * PdfPageFormat.mm,
                  left: 1.0 * PdfPageFormat.cm,
                  right: 1.0 * PdfPageFormat.cm),
              child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Copyright © $formatter | Revergon Solutions Private Limited | All Rights Reserved.',
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(color: PdfColors.grey, fontSize: 6),
                    ),
                    pw.Text(
                      'Report ID: 9001_1048',
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(color: PdfColors.grey, fontSize: 6),
                    ),
                  ]),
            );
          },
          pageTheme: const pw.PageTheme(margin: pw.EdgeInsets.all(0)),
          build: (context) => [
                pw.Container(
                  width: double.infinity,
                  height: size.height * 0.8,
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
                                pw.MemoryImage(revergonLogo),
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
          footer: (context) {
            return pw.Container(
              alignment: pw.Alignment.centerRight,
              margin: const pw.EdgeInsets.only(
                  bottom: 2 * PdfPageFormat.mm,
                  left: 1.0 * PdfPageFormat.cm,
                  right: 1.0 * PdfPageFormat.cm),
              child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'Copyright © $formatter | Revergon Solutions Private Limited | All Rights Reserved.',
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(color: PdfColors.grey, fontSize: 6),
                    ),
                    pw.Text(
                      'Report ID: 9001_1048',
                      style: pw.Theme.of(context)
                          .defaultTextStyle
                          .copyWith(color: PdfColors.grey, fontSize: 6),
                    ),
                  ]),
            );
          },
          pageTheme: const pw.PageTheme(margin: pw.EdgeInsets.all(0)),
          build: (context) => [
                pw.Container(
                  width: double.infinity,
                  height: size.height * 0.8,
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
                                pw.MemoryImage(revergonLogo),
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
    return await pdf.save();
  }
}
