import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;

import 'appConstants.dart';

class AppConstantConflicts {
  static Future setDeviceDirectoryForImages() async {
    String path = (await getApplicationDocumentsDirectory()).path + '/Images';

    Directory(path).exists().then((exist) {
      if (exist == false) {
        Directory(path).createSync();
      }
      AppConstants.deviceDirectoryPathImages = path;
    });
  }

  static writeImageFileIntoDisk(String url) async {
    if (url == null || url.isEmpty) return null;

    final parsed = _diskRWableImageUrl(url);

    File file = File('${AppConstants.deviceDirectoryPathImages}/$parsed');

    if (file.existsSync() == false) {
      http.get(url).catchError((error) {
        print('Error in downloading image : $error');
      }).then((response) {
        if (response != null && response.statusCode == 200) {
          final imageData = response.bodyBytes.toList();
          final File writingFile =
              File('${AppConstants.deviceDirectoryPathImages}/$parsed');
          writingFile.writeAsBytesSync(imageData);
          print('image saved into disk ');
        }
      });
    }
  }

  static String _diskRWableImageUrl(String imageUrl) {
    String parsedUrl = '';
    for (var element in imageUrl.split('/')) {
      parsedUrl += element;
    }
    return parsedUrl;
  }

  static File getImageFile(String url) {
    if (url == null || url.isEmpty) return null;

    File file;

    final parsed = _diskRWableImageUrl(url);

    file = File('${AppConstants.deviceDirectoryPathImages}/$parsed');

    if (file.existsSync()) {
      return file;
    } else
      return null;
  }

  static Future deleteAllLocalImages() async {
    Directory(AppConstants.deviceDirectoryPathImages)
        .listSync(recursive: true)
        .forEach((f) {
      print('deleted : ' +
          (f.path.split('Images/').length > 1
              ? f.path.split('Images/')[1]
              : 'nothing was here'));
      f.deleteSync();
    });
  }
}
