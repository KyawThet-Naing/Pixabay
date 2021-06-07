import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:pixabay/ob/response_ob.dart';

class DownloadedBloc {
  StreamController<ResponseOb> _controller = StreamController<ResponseOb>();

  Stream<ResponseOb> getDownloadedImageStream() => _controller.stream;

  getDownloadedImage() async {
    ResponseOb responseOb = ResponseOb(msgState: MsgState.loading);
    _controller.sink.add(responseOb);
    Directory? directory = await getExternalStorageDirectory();
    Directory path = Directory('${directory!.path}/../../../../PixabayImage');
    List<FileSystemEntity> downloadData = path.listSync();
    responseOb.msgState = MsgState.data;
    responseOb.data = downloadData;
    _controller.sink.add(responseOb);
  }

  deleteImage(FileSystemEntity file) {
    file.delete();
    getDownloadedImage();
  }

  disposed() => _controller.close();
}
