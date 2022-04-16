import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

Future<void> shareWithImageIO(Uri uri, dynamic widget) async {
  try {
    var request =
        await HttpClient().getUrl(Uri.parse(widget.map.small_image_url));

    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);

    final tempDir = await getTemporaryDirectory();
    final file = await new File('${tempDir.path}/pic_to_share.png').create();
    await file.writeAsBytes(bytes);

    await Share.shareFiles(['${tempDir.path}/pic_to_share.png'],
        subject: '${widget.map.name}',
        text:
            'Do Subscribe ${widget.map.name} to stay updated about upcoming workshops and events: ${uri.toString()}');
  } catch (err) {
    shareWithoutImage(uri, widget);
  }
}

Future<void> shareWithoutImage(Uri uri, dynamic widget) async {
  Share.share(
    'Do Subscribe ${widget.map.name} to stay updated about upcoming workshops and events: ${uri.toString()}',
    subject: '${widget.map.name}',
  );
}
