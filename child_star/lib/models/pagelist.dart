class PageList<T> {
  static const KEY_PAGE_INDEX = "pageNum";
  static const KEY_PAGE_SIZE = "pageSize";
  static const KEY_PAGE_TOTAL = "totalNum";
  static const KEY_PAGE_LIST = "resultList";
  PageList();

  PageList.page(Map<String, dynamic> response, T f(dynamic json)) {
    pageNum = response[KEY_PAGE_INDEX];
    pageSize = response[KEY_PAGE_SIZE];
    totalNum = response[KEY_PAGE_TOTAL];
    List<dynamic> list = response[KEY_PAGE_LIST];
    resultList = list.map((json) => f(json)).toList();
  }

  List<T> resultList;
  num pageNum;
  num pageSize;
  num totalNum;
}
