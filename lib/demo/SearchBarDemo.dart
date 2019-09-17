import 'package:flutter/material.dart';

class SearchBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "SearchBarDemo",
      theme: ThemeData.light(),
      home: SearchBarStful(),
    );
  }
}

class SearchBarStful extends StatefulWidget {
  @override
  _SearchBarStfulState createState() => _SearchBarStfulState();
}

class _SearchBarStfulState extends State<SearchBarStful> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("SearchBarDemo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: SearchBarDelegate());
            },
          )
        ],
      ),
    );
  }
}

class SearchBarDelegate extends SearchDelegate {
  static const searchList = [
    "jiejie-大长腿",
    "jiejie-水蛇腰",
    "gege1-帅气欧巴",
    "gege2-小鲜肉"
  ];

  static const recentSuggest = ["推荐-1", "推荐-2"];

  @override
  Widget buildSuggestions(BuildContext context) {
    //设置推荐，就是我们输入一个字，然后自动为我们推送相关的搜索结果，这样的体验是非常好的
    final suggestionList = query.isEmpty
        ? recentSuggest
        : searchList.where((input) => input.startsWith(query)).toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        title: RichText(
          text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.grey),
                )
              ]),
        ),
      ),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    //搜索条右侧的按钮执行方法，我们在这里方法里放入一个clear图标。 当点击图片时，清空搜索的内容。
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () => query = "",
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    //搜索栏左侧的图标和功能的编写，这里我们才用AnimatedIcon，然后在点击时关闭整个搜索页面
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //搜到到内容后的展现
    return Container(
      width: 100.0,
      height: 100.0,
      child: Card(
        color: Colors.redAccent,
        child: Text(query),
      ),
    );
  }
}
