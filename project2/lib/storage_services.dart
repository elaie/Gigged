import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'dart:io';
class Storage {
  final firebase_storage.FirebaseStorage storage = firebase_storage
      .FirebaseStorage.instance;

  Future<void> uploadFile(String filePath,
      String fileName,) async {
    File file = File(filePath);

    try {
      await storage.ref('test/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<firebase_storage.ListResult> listFiles() async {
    firebase_storage.ListResult results = await storage.ref('test').listAll();

    results.items.forEach((firebase_storage.Reference ref) {
      print('Found files: $ref');
    });
    return results;
  }

  Future<String> downloadURL(String imageName) async{
    String downloadURL = await storage.ref("test/$imageName").getDownloadURL();

    return downloadURL;
  }

  Future<File> changeFileNameOnly(File file, String newFileName) {
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }
}