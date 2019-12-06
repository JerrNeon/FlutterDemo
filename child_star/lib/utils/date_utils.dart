///秒格式化（时分秒）
String getTimeFromSecond(dynamic secondTime) {
  try {
    int second;
    if (secondTime is String) {
      second = int.tryParse(secondTime);
    } else if (secondTime is int) {
      second = secondTime;
    } else if (secondTime is double) {
      second = secondTime.toInt();
    } else {
      return "";
    }
    if (second < 10) {
      return "00:0$second";
    }
    if (second < 60) {
      return "00:$second";
    }
    if (second < 3600) {
      int minute = second ~/ 60;
      second = second - minute * 60;
      if (minute < 10) {
        if (second < 10) {
          return "0$minute:0$second";
        }
        return "0$minute:$second";
      }
      if (second < 10) {
        return "$minute:0$second";
      }
      return "$minute:$second";
    }
    int hour = second ~/ 3600;
    int minute = (second - hour * 3600) ~/ 60;
    second = second - hour * 3600 - minute * 60;
    if (hour < 10) {
      if (minute < 10) {
        if (second < 10) {
          return "0$hour:0$minute:0$second";
        }
        return "0$hour:0$minute:$second";
      }
      if (second < 10) {
        return "0$hour$minute:0$second";
      }
      return "0$hour$minute :$second";
    }
    if (minute < 10) {
      if (second < 10) {
        return "$hour:0$minute:0$second";
      }
      return "$hour:0$minute:$second";
    }
    if (second < 10) {
      return "$hour$minute:0$second";
    }
    return "$hour$minute:$second";
  } catch (e) {
    return "";
  }
}
