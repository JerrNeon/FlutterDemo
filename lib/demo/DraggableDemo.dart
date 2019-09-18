import 'package:flutter/material.dart';

class DraggableDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "DraggableDemo",
      theme: ThemeData.light(),
      home: DraggableWidget(),
    );
  }
}

class DraggableWidget extends StatefulWidget {
  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  Color _draggableColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Draggable Demo"),
        ),
        body: Stack(
          children: <Widget>[
            DraggableChildWidget(
              offset: Offset(80.0, 80.0),
              widgetColor: Colors.tealAccent,
            ),
            DraggableChildWidget(
              offset: Offset(180.0, 80.0),
              widgetColor: Colors.redAccent,
            ),
            Center(
              child: DragTarget(
                builder: (context, candidateData, rejectedData) {
                  return Container(
                    width: 200.0,
                    height: 200.0,
                    color: _draggableColor,
                  );
                },
                //当推拽到控件里时触发
                onAccept: (Color color) {
                  _draggableColor = color;
                },
              ),
            )
          ],
        ));
  }
}

///支持拖拽的Widget
class DraggableChildWidget extends StatefulWidget {
  final Offset offset;
  final Color widgetColor;

  const DraggableChildWidget({Key key, this.offset, this.widgetColor})
      : super(key: key);

  @override
  _DraggableChildWidgetState createState() => _DraggableChildWidgetState();
}

class _DraggableChildWidgetState extends State<DraggableChildWidget> {
  Offset offset = Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    offset = widget.offset;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: offset.dx,
        top: offset.dy,
        child: Draggable(
          data: widget.widgetColor, //是要传递的参数
          child: Container(
            width: 100.0,
            height: 100.0,
            color: widget.widgetColor,
          ),
          feedback: Container(
            width: 100.0,
            height: 100.0,
            color: widget.widgetColor.withOpacity(0.5),
          ),
          onDraggableCanceled: (Velocity velocity, Offset offset) {
            setState(() {
              this.offset = offset;
            });
          },
        ));
  }
}
