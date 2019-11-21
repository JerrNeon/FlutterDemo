import 'package:flutter/material.dart';
import 'package:flutter_demo/i10n/localization_intl.dart';
import 'package:flutter_demo/states/ProfileChangeNotifier.dart';
import 'package:provider/provider.dart';

class LanguageRoute extends StatefulWidget {
  @override
  _LanguageRouteState createState() => _LanguageRouteState();
}

class _LanguageRouteState extends State<LanguageRoute> {
  @override
  Widget build(BuildContext context) {
    var color = Theme.of(context).primaryColor;
    var localModel = Provider.of<LocaleModel>(context);
    var gm = GmLocalizations.of(context);

    Widget _buildLanguageItem(String lan, value) {
      return ListTile(
        title: Text(
          lan,
          // 对APP当前语言进行高亮显示
          style: TextStyle(
              color: localModel.locale == value ? color : null, fontSize: 14),
        ),
        trailing:
            localModel.locale == value ? Icon(Icons.done, color: color) : null,
        onTap: () {
          // 更新locale后MaterialApp会重新build
          localModel.locale = value;
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(gm.language),
      ),
      body: ListView(
        children: <Widget>[
          _buildLanguageItem("中文简体", "zh_CN"),
          _buildLanguageItem("English", "en_US"),
          _buildLanguageItem(gm.auto, null),
        ],
      ),
    );
  }
}
