import 'dart:async';

import 'package:child_star/common/net/net_manager.dart';
import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/states/states_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final GlobalKey<FormFieldState> _phoneGlobalKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyCodeController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _verifyCodeFocusNode = FocusNode();

  static const TOTAL_TIME = 60; //总倒计时时长(单位：s)
  Timer _timer; //倒计时
  var _currentTime = 0; //当前倒计时剩余时长(单位：s)

  @override
  void dispose() {
    super.dispose();
    if (_timer != null && _timer.isActive) {
      _timer.cancel();
      _timer = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final gm = GmLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(image: MyImages.bg_login, fit: BoxFit.cover),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _buildBack(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildWelcome(),
                _buildTop(gm),
                _buildInput(gm),
                _buildRegisterBtn(gm),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBack() {
    return Positioned(
      left: 0,
      top: 0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MySizes.s_10, vertical: MySizes.s_30),
          child: Image(image: MyImages.ic_login_back),
        ),
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
            //手机号、获取验证码
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    key: _phoneGlobalKey,
                    controller: _phoneController,
                    focusNode: _phoneFocusNode,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(MySizes.s_24),
                          bottomLeft: Radius.circular(MySizes.s_24),
                        ),
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
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    onEditingComplete: () => FocusScope.of(context)
                        .requestFocus(_verifyCodeFocusNode),
                    validator: (value) {
                      if (!RegexUtils.checkMobile(value)) {
                        return gm.loginMobileErrorTitle;
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  width: MySizes.s_1,
                  height: MySizes.s_36,
                  color: MyColors.c_a1a1a1,
                  margin: EdgeInsets.symmetric(vertical: MySizes.s_2),
                ),
                GestureDetector(
                  onTap: () => _getVerifyCode(gm),
                  child: Container(
                    width: MySizes.s_82,
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(vertical: MySizes.s_13),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(MySizes.s_24),
                        bottomRight: Radius.circular(MySizes.s_24),
                      ),
                    ),
                    child: Text(
                      _currentTime == 0
                          ? gm.registerGetVerificationCodeTitle
                          : "${_currentTime}s",
                      style: TextStyle(
                        color: MyColors.c_a1a1a1,
                        fontSize: MyFontSizes.s_12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(padding: EdgeInsets.only(top: MySizes.s_22)),
            //验证码
            TextFormField(
              controller: _verifyCodeController,
              focusNode: _verifyCodeFocusNode,
              decoration: InputDecoration(
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(MySizes.s_24),
                ),
                contentPadding: EdgeInsets.all(MySizes.s_12),
                isDense: true,
                hintText: gm.registerVerificationCodeHintTitle,
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
              maxLength: 6,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              onEditingComplete: () =>
                  FocusScope.of(context).requestFocus(_passwordFocusNode),
              validator: (value) {
                if (!RegexUtils.checkPassword(value)) {
                  return gm.registerVerificationCodeErrorTitle;
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

  Widget _buildRegisterBtn(GmLocalizations gm) {
    return Padding(
      padding: EdgeInsets.only(top: MySizes.s_28),
      child: MaterialButton(
        onPressed: () => _register(),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MySizes.s_24),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: MySizes.s_50,
        ),
        child: Text(
          gm.registerTitle,
          style: TextStyle(
            color: MyColors.c_ffa2b1,
            fontSize: MyFontSizes.s_14,
          ),
        ),
      ),
    );
  }

  _getVerifyCode(GmLocalizations gm) async {
    if (_currentTime == 0 && _phoneGlobalKey.currentState.validate()) {
      var mobile = _phoneController.text;
      showLoading(context);
      LogUtils.d("mobile: $mobile");
      try {
        await NetManager(context).getVerifyCode(mobile: mobile);
        _currentTime = TOTAL_TIME;
        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          _currentTime--;
          if (_currentTime == 0) {
            timer.cancel();
          }
          setState(() {});
        });
        showToast(gm.registerVerificationCodeSendSuccess);
      } catch (e) {} finally {
        Navigator.of(context).pop();
      }
    }
  }

  _register() async {
    if (_globalKey.currentState.validate()) {
      var mobile = _phoneController.text;
      var password = _passwordController.text;
      var code = _verifyCodeController.text;
      showLoading(context);
      LogUtils.d("mobile: $mobile , password: $password , code: $code");
      try {
        NetManager netManager = NetManager(context);
        Token token = await netManager.register(
            mobile: mobile, password: password, code: code);
        UserProvider userProvider =
            Provider.of<UserProvider>(context, listen: false);
        userProvider.token = token.token;
        User user = await netManager.getUserInfo();
        userProvider.user = user;
        //退出注册界面
        Navigator.of(context).pop('');
      } catch (e) {} finally {
        Navigator.of(context).pop();
      }
    }
  }
}
