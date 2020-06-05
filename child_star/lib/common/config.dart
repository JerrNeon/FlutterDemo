class MediaType {
  static const ARTICLE = 0;
  static const VIDEO = 1;
  static const AUDIO = 2;
  static const ENCYCLOPEDIA = 3;
}

class XmlyType {
  static const RECENT = -1;
  static const COLLECT = -2;
}

class XmlyData {
  static const COLUMN_HOT_ID = 6976;
  static const COLUMN_POP_ID = 6977;
  static const COLUMN_IDS = "6976,6977,6880,6884,6879";
  static const PAGE_SIZE = 20;

  static int albumId; //专辑id
  static bool isAsc; //是否升序
  static int totalPage;
  static int totalSize;
  static int pageSize;
  static int prePage;
  static int page;
}
