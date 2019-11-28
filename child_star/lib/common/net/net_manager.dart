import 'package:child_star/common/net/net.dart';
import 'package:child_star/models/index.dart';
import 'package:flutter/material.dart';

import 'net_config.dart';

class NetManager {
  NetManager([this.context]);

  final BuildContext context;

  Future<List<Tag>> getHotTagList() async {
    List response = await Net(context).post(NetConfig.GET_HOT_TAGS);
    return response.map((e) => Tag.fromJson(e)).toList();
  }
}
