import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:rev_pdf/save_launch.dart';

class PageoneData {
  final String attribute;
  final String value;
  PageoneData({required this.attribute, required this.value});
}

class PdfApi {
  // static Future<Uint8List> createDocument() {
  //   final pdf = pw.Document();
  //   pdf.addPage(pw.Page(build: (pw.Context context) {
  //     return pw.Center(child: pw.Text("Hello World"));
  //   }));
  //   return pdf.save();
  // }
  // static Future<File> createDocument() async {
  //   final pdf = pw.Document();
  //   final font = await PdfGoogleFonts.nunitoExtraLight();
  //   final cellStyle =
  //       pw.TextStyle(font: font, fontSize: 12, fontWeight: pw.FontWeight.bold);

  //   final headers = ['Name', 'Age'];

  //   final users = [
  //     PageoneData(attribute: 'Organisation', value: 'Infosys'),
  //     PageoneData(attribute: 'Date', value: 'Infosys'),
  //     PageoneData(attribute: 'Place', value: 'Infosys'),
  //   ];
  //   final data = users.map((user) => [user.attribute, user.value]).toList();

  //   pdf.addPage(pw.Page(
  //     build: (context) => pw.Table.fromTextArray(
  //         headers: headers, data: data, cellStyle: cellStyle),
  //   ));
//   Future<void> createPDF() async {
//   //Create a new PDF document
//   PdfDocument document = PdfDocument();
//   PdfPage page = document.pages.add();

//   //Add a new page and draw text
//   // page.graphics.drawString(
//   //     'Hello World!', PdfStandardFont(PdfFontFamily.helvetica, 20),
//   //     brush: PdfSolidBrush(PdfColor(0, 0, 0)),
//   //     bounds: Rect.fromLTWH(0, 0, 500, 50));
//      page.graphics.drawImage(
//     PdfBitmap(File('assets/images/image.jpeg').readAsBytesSync()),
//     Rect.fromLTWH(
//         0, 0, page.getClientSize().width, page.getClientSize().height));

// //Saves the document
// File('Output.pdf').writeAsBytes(await document.save());

//   //Save the document
//   List<int> bytes = await document.save();

//   //Dispose the document
//   document.dispose();
//   saveAndLaunchFile(bytes, 'Output.pdf');
// }
  //   return saveDocument(name: 'my_example.pdf', pdf: pdf);
  // }
  static Future<File> createDocument() async {
    print("I am here3");
    // final imageSvg = await rootBundle.loadString('assets/images/image1.svg');
    final imagejpeg = (await rootBundle.load('assets/images/image.jpeg')).buffer.asUint8List();

    final pdf = pw.Document();
    pdf.addPage(pw.MultiPage(build: (context) => [
      pw.Image(pw.MemoryImage(imagejpeg))
      ]));
    return saveDocument(name: 'my_example.pdf', pdf: pdf);
  }
}
