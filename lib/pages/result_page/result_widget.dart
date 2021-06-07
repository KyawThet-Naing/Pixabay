import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pixabay/ob/result_ob.dart';
import 'package:pixabay/pages/detail_page/detail.dart';
import 'package:pixabay/utils/global_widget.dart';

class ResultWidget extends StatelessWidget {
  final ResultOb resultOb;

  const ResultWidget({Key? key, required this.resultOb}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => Detail(resultOb: resultOb))),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Hero(
              tag: resultOb.webformatURL!,
              child: CachedNetworkImage(
                  height: 180,
                  fit: BoxFit.cover,
                  imageUrl: resultOb.webformatURL!,
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
                      imageUrl: resultOb.userImageURL!,
                      placeholder: (_, __) =>
                          GlobalWidget.showLoading(context: context),
                      errorWidget: (_, __, ___) =>
                          Center(child: Icon(Icons.error, color: Colors.red)))),
              title: Text(resultOb.user!),
            ),
            Divider(color: Colors.black.withOpacity(.2), thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Icon(Icons.remove_red_eye,
                        color: Theme.of(context).primaryColor),
                    Text(resultOb.views.toString())
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.download_rounded, color: Colors.blue),
                    Text(resultOb.downloads.toString())
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.favorite, color: Colors.red),
                    Text(resultOb.favorites.toString())
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.thumb_up_alt, color: Colors.orange),
                    Text(resultOb.likes.toString())
                  ],
                ),
                Column(
                  children: [
                    Icon(Icons.comment, color: Colors.green),
                    Text(resultOb.comments.toString())
                  ],
                ),
              ],
            ),
            SizedBox(height: 10)
          ],
        ),
      ),
    );
  }
}
