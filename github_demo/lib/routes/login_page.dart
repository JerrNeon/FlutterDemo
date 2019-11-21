import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo/common/global.dart';
import 'package:flutter_demo/common/net.dart';
import 'package:flutter_demo/common/utils.dart';
import 'package:flutter_demo/i10n/localization_intl.dart';
import 'package:flutter_demo/models/index.dart';
import 'package:flutter_demo/states/ProfileChangeNotifier.dart';
import 'package:provider/provider.dart';

class LoginRoute extends StatefulWidget {
  @override
  _LoginRouteState createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  bool pwdShow = false; //密码是否明文显示
  GlobalKey _formKey = GlobalKey<FormState>();
  bool _nameAutoFocus = true;
  bool _autovalidate = false;

  @override
  void initState() {
    //自动填充上次使用的用户名，填充后将焦点定位到密码输入框
    _unameController.text = Global.profile.lastLogin;
    if (_unameController.text.isNotEmpty) {
      _nameAutoFocus = false;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(gm.login)),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            key: _formKey,
            autovalidate: _autovalidate, //是否自动校验
            child: Column(
              children: <Widget>[
                TextFormField(
                  autofocus: _nameAutoFocus,
                  controller: _unameController,
                  decoration: InputDecoration(
                    labelText: gm.userName,
                    hintText: gm.userName,
                    prefixIcon: Icon(Icons.person),
                  ),
                  //校验用用户(不能为空)
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : gm.userNameRequired;
                  },
                ),
                TextFormField(
                  autofocus: !_nameAutoFocus,
                  controller: _pwdController,
                  decoration: InputDecoration(
                    labelText: gm.password,
                    hintText: gm.password,
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                        icon: Icon(
                            pwdShow ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            pwdShow = !pwdShow;
                          });
                        }),
                  ),
                  obscureText: !pwdShow,
                  //校验密码不能为空
                  validator: (v) {
                    return v.trim().isNotEmpty ? null : gm.passwordRequired;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25),
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 55),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                      onPressed: _login,
                      child: Text(gm.login),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  void _login() async {
    //提交前，先验证各个表单字段是否合法
    if ((_formKey.currentState as FormState).validate()) {
      showLoading(context);
      User user;
      try {
        user = await Net(context)
            .login(_unameController.text.trim(), _pwdController.text.trim());
        // 因为登录页返回后，首页会build，所以我们传false，更新user后不触发更新
        Provider.of<UserModel>(context, listen: false).user = user;
      } on DioError catch (e) {
        //登录失败提示
        if (e.response?.statusCode == 401) {
          showToast(GmLocalizations.of(context).userNameOrPasswordWrong);
        } else {
          showToast(e.toString());
        }
      } finally {
        //隐藏loading
        Navigator.of(context).pop();
      }
      if (user != null) {
        // 返回
        Navigator.of(context).pop();
      }
    } else {
      setState(() {
        _autovalidate = true;
      });
    }
  }
}
