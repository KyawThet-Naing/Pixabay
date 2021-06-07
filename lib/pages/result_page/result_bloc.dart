import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pixabay/ob/response_ob.dart';
import 'package:pixabay/ob/result_ob.dart';
import 'package:pixabay/utils/app_constants.dart';

class ResultBloc {
  StreamController<ResponseOb> _controller =
      StreamController<ResponseOb>.broadcast();

  Stream<ResponseOb> resultStream() => _controller.stream;
  int page = 1;

  searchImage({required String searchName, required String type}) async {
    ResponseOb _responseOb = ResponseOb(msgState: MsgState.loading);
    page = 1;
    // _controller.sink.add(_responseOb);
    http.Response response = await http.get(Uri.parse(
        '$BASE_URL?key=$API_KEY&q=$searchName&image_type=$type&page=$page'));
    if (response.statusCode == 200) {
      List<ResultOb> _results = [];
      List<dynamic> resultList = jsonDecode(response.body)['hits'];
      _results = resultList.map((e) => ResultOb.fromJson(e)).toList();
      _responseOb.msgState = MsgState.data;
      _responseOb.data = _results;
      _responseOb.pageState = PageState.first;
      _controller.sink.add(_responseOb);
    } else if (response.statusCode == 500) {
      _responseOb.msgState = MsgState.error;
      _responseOb.errState = ErrState.serverErr;
      _controller.sink.add(_responseOb);
    } else if (response.statusCode == 404) {
      _responseOb.msgState = MsgState.error;
      _responseOb.errState = ErrState.notFoundErr;
      _controller.sink.add(_responseOb);
    } else {
      _responseOb.msgState = MsgState.error;
      _responseOb.errState = ErrState.unknownErr;
      _controller.sink.add(_responseOb);
    }
  }

  searchImageLoadMore(
      {required String searchName, required String type}) async {
    ResponseOb _responseOb = ResponseOb(msgState: MsgState.loading);
    // _controller.sink.add(_responseOb);
    page++;
    http.Response response = await http.get(Uri.parse(
        '$BASE_URL?key=$API_KEY&q=$searchName&image_type=$type&page=$page'));
    if (response.statusCode == 200) {
      List<ResultOb> _results = [];
      List<dynamic> resultList = jsonDecode(response.body)['hits'];
      _results = resultList.map((e) => ResultOb.fromJson(e)).toList();
      _responseOb.msgState = MsgState.data;
      _responseOb.data = _results;
      _responseOb.pageState = PageState.load;
      _controller.sink.add(_responseOb);
    } else if (response.statusCode == 500) {
      _responseOb.msgState = MsgState.error;
      _responseOb.errState = ErrState.serverErr;
      _controller.sink.add(_responseOb);
    } else if (response.statusCode == 404) {
      _responseOb.msgState = MsgState.error;
      _responseOb.errState = ErrState.notFoundErr;
      _controller.sink.add(_responseOb);
    } else {
      _responseOb.msgState = MsgState.error;
      _responseOb.errState = ErrState.unknownErr;
      _controller.sink.add(_responseOb);
    }
  }

  disposed() => _controller.close();
}
