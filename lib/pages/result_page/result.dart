import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixabay/ob/response_ob.dart';
import 'package:pixabay/ob/result_ob.dart';
import 'package:pixabay/pages/result_page/result_bloc.dart';
import 'package:pixabay/pages/result_page/result_widget.dart';
import 'package:pixabay/utils/global_widget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class Result extends StatefulWidget {
  final String name;

  const Result({Key? key, required this.name}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  ResultBloc _resultBloc = ResultBloc();
  RefreshController _refreshController = RefreshController();

  List<ResultOb> images = [];

  @override
  void initState() {
    _resultBloc.searchImage(searchName: widget.name, type: 'all');
    _resultBloc.resultStream().listen((ResponseOb ob) {
      if (ob.msgState == MsgState.data) {
        if (ob.pageState == PageState.first) {
          _refreshController.refreshCompleted();
          _refreshController.resetNoData();
        } else if (ob.pageState == PageState.load) {
          if (ob.data.length < 20) {
            _refreshController.loadNoData();
          } else
            _refreshController.loadComplete();
        }
      } else if (ob.msgState == MsgState.error) {
        _refreshController.refreshFailed();
      } else {
        _refreshController.refreshFailed();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _resultBloc.disposed();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: StreamBuilder<ResponseOb>(
        stream: _resultBloc.resultStream(),
        initialData: ResponseOb(msgState: MsgState.loading),
        builder: (_, AsyncSnapshot<ResponseOb> snapshot) {
          ResponseOb resp = snapshot.data!;
          if (resp.msgState == MsgState.data) {
            if (resp.pageState == PageState.first) {
              images = resp.data;
            }
            if (resp.pageState == PageState.load) {
              images.addAll(resp.data);
            }
            return SmartRefresher(
              physics: BouncingScrollPhysics(),
              controller: _refreshController,
              header: ClassicHeader(),
              enablePullDown: true,
              enablePullUp: images.length > 19,
              // enablePullUp: true, (default -> true)
              onRefresh: () =>
                  _resultBloc.searchImage(searchName: widget.name, type: 'all'),
              onLoading: () => _resultBloc.searchImageLoadMore(
                  searchName: widget.name, type: 'all'),
              child: ListView(
                  children:
                      images.map((e) => ResultWidget(resultOb: e)).toList()),
            );
          } else if (resp.msgState == MsgState.loading) {
            return GlobalWidget.showLoading(context: context);
          } else {
            if (resp.errState == ErrState.serverErr) {
              return Center(child: Text('500\nServer Error'));
            } else if (resp.errState == ErrState.notFoundErr) {
              return Center(child: Text('404\nNot Found Error'));
            } else
              return Center(child: Text('Unknown Error'));
          }
        },
      ),
    );
  }
}
