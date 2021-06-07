import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator_ns/liquid_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pixabay/ob/result_ob.dart';
import 'package:pixabay/utils/global_widget.dart';
import 'package:path/path.dart';

class Detail extends StatefulWidget {
  final ResultOb resultOb;

  const Detail({Key? key, required this.resultOb}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  num count = 0;
  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('img_detail')),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Hero(
            tag: widget.resultOb.webformatURL!,
            child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.resultOb.webformatURL!,
                placeholder: (_, __) =>
                    GlobalWidget.showLoading(context: context),
                errorWidget: (_, __, ___) =>
                    Center(child: Icon(Icons.error, color: Colors.red))),
          ),
          ListTile(
            leading: ClipOval(
                child: CachedNetworkImage(
                    height: 45,
                    width: 45,
                    fit: BoxFit.cover,
                    imageUrl: widget.resultOb.userImageURL!,
                    placeholder: (_, __) =>
                        GlobalWidget.showLoading(context: context),
                    errorWidget: (_, __, ___) =>
                        Center(child: Icon(Icons.error, color: Colors.red)))),
            title: Text(widget.resultOb.user!),
          ),
          Divider(color: Colors.black.withOpacity(.2), thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Icon(Icons.remove_red_eye,
                      color: Theme.of(context).primaryColor),
                  Text(widget.resultOb.views.toString())
                ],
              ),
              Column(
                children: [
                  Icon(Icons.download_rounded, color: Colors.blue),
                  Text(widget.resultOb.downloads.toString())
                ],
              ),
              Column(
                children: [
                  Icon(Icons.favorite, color: Colors.red),
                  Text(widget.resultOb.favorites.toString())
                ],
              ),
              Column(
                children: [
                  Icon(Icons.thumb_up_alt, color: Colors.orange),
                  Text(widget.resultOb.likes.toString())
                ],
              ),
              Column(
                children: [
                  Icon(Icons.comment, color: Colors.green),
                  Text(widget.resultOb.comments.toString())
                ],
              ),
            ],
          ),
          SizedBox(height: 10),
          !isDownloading
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      color: Theme.of(context).primaryColor,
                      onPressed: () async {
                        var permissionStatus = await Permission.storage.status;
                        if (permissionStatus.isDenied) {
                          await Permission.storage.request().then((value) {
                            if (value.isGranted) {
                              _downloadImg(context);
                            }
                          });
                        } else if (permissionStatus.isGranted) {
                          _downloadImg(context);
                        }
                      },
                      child: Text(
                        tr('download'),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      )),
                )
              : Center(
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: LiquidCircularProgressIndicator(
                      value: count / 100,
                      // Defaults to 0.5.
                      valueColor: AlwaysStoppedAnimation(
                          Theme.of(context).primaryColor),
                      // Defaults to the current Theme's accentColor.
                      backgroundColor:
                          Theme.of(context).primaryColor.withOpacity(.3),
                      // Defaults to the current Theme's backgroundColor.
                      borderColor: Theme.of(context).primaryColor,
                      borderWidth: 2.0,
                      direction: Axis.vertical,
                      // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.vertical.
                      center: Text("$count %"),
                    ),
                  ),
                )
        ],
      ),
    );
  }

  _downloadImg(BuildContext context) async {
    setState(() {
      isDownloading = true;
    });
    Directory? directory = await getExternalStorageDirectory();
    String path =
        '${directory!.path}/../../../../PixabayImage/${DateTime.now().millisecond}${basename(widget.resultOb.largeImageURL!)}';

    await Dio().download(widget.resultOb.largeImageURL!, path,
        onReceiveProgress: (receive, total) {
      num percent = (receive / total) * 100;
      setState(() {
        count = int.parse(percent.toStringAsFixed(0));
      });

      if (percent == 100) {
        setState(() {
          isDownloading = false;
          count = 0;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Theme.of(context).primaryColor,
          content: Text(
            tr('saved'),
            style: TextStyle(
                fontFamily:
                    context.locale.languageCode == 'my' ? 'MM3' : 'CreteRound',
                color: Colors.white,
                fontSize: 14),
          ),
        ));
      }
    });
  }
}
