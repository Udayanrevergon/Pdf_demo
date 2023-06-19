import 'package:open_document/my_files/init.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

Future<File> saveDocument({
  required String name,
  required Document pdf,
}) async {
  final bytes = await pdf.save();
  print("I am here1");

  final dir = await getExternalStorageDirectory();
  final file = File('${dir!.path}/$name');

  await file.writeAsBytes(bytes);
  print("I am here1");
  print(file);
  return file;
}

Future openFile(File file) async {
  print("I am here2");
  final url = file.path;

  await OpenFile.open(url);
}


// List<int> bytes, String fileName) async {
//   final path = (await getExternalStorageDirectory())!.path;
// //   final file = File('$path/$fileName');
// //   await file.writeAsBytes(bytes, flush: true);
// //   OpenFile.open('$path/$fileName');
// Future<void> savePdfFile(String fileName, Uint8List byteList) async {
  
//   await OpenDocument.openDocument(filePath: filePath);
// }
