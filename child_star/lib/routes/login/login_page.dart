import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/common/router/routers_navigate.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/states/states_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    StatusBarUtils.setTransparent();
  }

  @override
  void deactivate() {
    StatusBarUtils.setDark();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final gm = GmLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(image: MyImages.bg_login, fit: BoxFit.cover),
        ),
        child: Stack(
          children: <Widget>[
            _buildBack(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildWelcome(),
                _buildTop(gm),
                _buildInput(gm),
                _buildRegister(gm),
                _buildLoginBtn(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBack() {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.of(context).pop(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MySizes.s_10, vertical: MySizes.s_30),
        child: Image(image: MyImages.ic_login_back),
      ),
    );
  }

  Widget _buildWelcome() {
    return Padding(
      padding: EdgeInsets.only(top: MySizes.s_94),
      child: Image(image: MyImages.ic_login_hello),
    );
  }

  Widget _buildTop(GmLocalizations gm) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MySizes.s_20),
      child: Text(
        gm.loginWelcomeTitle,
        style: TextStyle(
          color: Colors.white,
          fontSize: MyFontSizes.s_18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildInput(GmLocalizations gm) {
    return SizedBox(
      width: MySizes.s_266,
      child: Form(
        key: _globalKey,
        child: Column(
          children: <Widget>[
            //手机号
            TextFormField(
              controller: _phoneController,
              focusNode: _phoneFocusNode,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(MySizes.s_24),
                ),
                contentPadding: EdgeInsets.all(MySizes.s_12),
                isDense: true,
                hintText: gm.loginMobileHintTitle,
                hintStyle: TextStyle(
                  fontSize: MyFontSizes.s_12,
                  color: MyColors.c_a1a1a1,
                ),
                //隐藏统计字数
                counterText: "",
              ),
              style: TextStyle(
                color: MyColors.c_686868,
                fontSize: MyFontSizes.s_12,
              ),
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.next,
              textAlign: TextAlign.center,
              autofocus: true,
              maxLength: 11,
              inputFormatters: [
                WhitelistingTextInputFormatter.digitsOnly,
              ],
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(_passwordFocusNode),
              validator: (value) {
                if (!RegexUtils.checkMobile(value)) {
                  return gm.loginMobileErrorTitle;
                }
                return null;
              },
            ),
            Padding(padding: EdgeInsets.only(top: MySizes.s_22)),
            //密码
            TextFormField(
              controller: _passwordController,
              focusNode: _passwordFocusNode,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(MySizes.s_24),
                ),
                contentPadding: EdgeInsets.all(MySizes.s_12),
                isDense: true,
                hintText: gm.loginPasswordHintTitle,
                hintStyle: TextStyle(
                  fontSize: MyFontSizes.s_12,
                  color: MyColors.c_a1a1a1,
                ),
                //隐藏统计字数
                counterText: "",
              ),
              style: TextStyle(
                color: MyColors.c_686868,
                fontSize: MyFontSizes.s_12,
              ),
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
              //是否隐藏输入，true密码样式显示，false明文显示
              obscureText: true,
              textAlign: TextAlign.center,
              maxLength: 16,
              validator: (value) {
                if (!RegexUtils.checkPassword(value)) {
                  return gm.loginPasswordErrorTitle;
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegister(GmLocalizations gm) {
    return Padding(
      padding: EdgeInsets.only(top: MySizes.s_10, bottom: MySizes.s_26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              var result = await RoutersNavigate().navigateToRegister(context);
              if (result != null) {
                Navigator.of(context).pop();
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                left: MySizes.s_6,
                top: MySizes.s_10,
                right: MySizes.s_20,
                bottom: MySizes.s_10,
              ),
              child: Text(
                gm.registerTitle,
                style:
                    TextStyle(color: Colors.white, fontSize: MyFontSizes.s_14),
              ),
            ),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => RoutersNavigate().navigateToForgetPassword(context),
            child: Padding(
              padding: EdgeInsets.only(
                left: MySizes.s_20,
                top: MySizes.s_10,
                right: MySizes.s_6,
                bottom: MySizes.s_10,
              ),
              child: Text(
                gm.loginForgetPasswordTitle,
                style:
                    TextStyle(color: Colors.white, fontSize: MyFontSizes.s_14),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return GestureDetector(
      onTap: () => _login(),
      child: Image(image: MyImages.ic_login_btn),
    );
  }

  _login() async {
    if (_globalKey.currentState.validate()) {
      var mobile = _phoneController.text;
      var password = _passwordController.text;
      try {
        showLoading(context);
        NetManager netManager = NetManager(context);
        Token token = await netManager.login(
          mobile: mobile,
          password: password,
        );
        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);
        userProvider.token = token.token;
        User user = await netManager.getUserInfo();
        userProvider.user = user;
        //退出登录界面
        Navigator.of(context).pop();
      } catch (e) {
        LogUtils.e(e);
      } finally {
        //关闭对话框
        Navigator.of(context).pop();
      }
    }
  }
}
