class ResponseOb {
  MsgState? msgState;
  ErrState? errState;
  PageState? pageState;
  dynamic data;

  ResponseOb({this.msgState, this.errState, this.data, this.pageState});
}

enum MsgState {
  loading,
  data,
  error,
  other,
}

enum ErrState {
  notFoundErr,
  serverErr,
  unknownErr,
}

enum PageState {
  first,
  load,
  no_more,
}
