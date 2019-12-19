# Flutter api

### 获取屏幕尺寸信息

```
    MediaQuery.of(context).size 
    MediaQuery.of(context).devicePixelRatio
```

### 获取控件尺寸信息

```
    1.声明GlobalKey globalKey = GlobalKey();
    2.设置某个Widget的key属性
    3.WidgetsBinding.instance.addPostFrameCallback((_){
      //获取尺寸
      globalKey.currentContext.size;
    });
```

### 获取父控件尺寸信息

```
    LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = constraints.maxHeight;
      },
    );
```