import 'package:flutter/material.dart';
import 'package:flutter_demo/bean/ExpandStateBean.dart';

class ExpansionPanelListDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "ExpansionPanelListDemo",
      theme: ThemeData.light(),
      home: ExpansionPanelListWidget(),
    );
  }
}

class ExpansionPanelListWidget extends StatefulWidget {
  @override
  _ExpansionPanelListWidgetState createState() =>
      _ExpansionPanelListWidgetState();
}

class _ExpansionPanelListWidgetState extends State<ExpansionPanelListWidget> {
  var currentPanelIndex = -1;
  List<int> mList; //组成一个int类型数组，用来控制索引
  List<ExpandStateBean> expandStateBeanList; //开展开的状态列表， ExpandStateBean是自定义的类

  @override
  void initState() {
    super.initState();
    mList = new List();
    expandStateBeanList = new List();
    for (int i = 0; i < 10; i++) {
      mList.add(i);
      expandStateBeanList.add(ExpandStateBean(false, i));
    }
  }

  _setCurrentIndex(int index, isExpand) {
    setState(() {
      expandStateBeanList.forEach((item) {
        if (item.index == index) {
          item.isOpen = !item.isOpen;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("ExpansionPanelListDemo"),
      ),
      body: new SingleChildScrollView(
        child: new ExpansionPanelList(
          expansionCallback: (int panelIndex, bool isExpanded) {
            _setCurrentIndex(panelIndex, isExpanded);
          },
          children: mList.map((index) {
            return ExpansionPanel(
                headerBuilder: (context, isExpanded) {
                  return ListTile(
                    title: Text('This is No.$index'),
                  );
                },
                body: ListTile(
                  title: Text("expansion no.$index"),
                ),
                isExpanded: expandStateBeanList[index].isOpen);
          }).toList(),
        ),
      ),
    );
  }
}
