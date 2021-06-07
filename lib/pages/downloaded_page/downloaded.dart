import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:pixabay/ob/response_ob.dart';
import 'package:pixabay/pages/downloaded_page/downloaded_bloc.dart';
import 'package:pixabay/utils/global_widget.dart';

class DownloadedImage extends StatefulWidget {
  const DownloadedImage({Key? key}) : super(key: key);

  @override
  _DownloadedImageState createState() => _DownloadedImageState();
}

class _DownloadedImageState extends State<DownloadedImage> {
  DownloadedBloc _downloadedBloc = DownloadedBloc();

  @override
  void initState() {
    _downloadedBloc.getDownloadedImage();
    super.initState();
  }

  @override
  void dispose() {
    _downloadedBloc.disposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('download_image')),
      ),
      body: StreamBuilder<ResponseOb>(
        stream: _downloadedBloc.getDownloadedImageStream(),
        initialData: ResponseOb(msgState: MsgState.loading),
        builder: (context, AsyncSnapshot<ResponseOb> snapshot) {
          ResponseOb responseObData = snapshot.data!;

          if (responseObData.msgState == MsgState.data) {
            List<FileSystemEntity> imageList = responseObData.data;
            List<FileSystemEntity> images = imageList.reversed.toList();

            return images.length == 0
                ? Center(
                    child: Text(
                      tr('no_image'),
                      style: GlobalWidget.buildTextStyle(),
                    ),
                  )
                : ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (_, index) => Card(
                            child: Column(
                          children: [
                            Image.file(File(images[index].path)),
                            MaterialButton(
                              minWidth: double.infinity,
                                onPressed: () =>
                                    _downloadedBloc.deleteImage(images[index]),
                                child: Icon(Icons.delete, color: Colors.red))
                          ],
                        )));
          } else if (responseObData.msgState == MsgState.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
