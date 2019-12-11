import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey();
  final GlobalKey<FormFieldState> _phoneGlobalKey = GlobalKey();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _verifyCodeController = TextEditingController();
  final FocusNode _phoneFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _verifyCodeFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    //设置状态栏透明
    SystemChrome.setSystemUIOverlayStyle(MySystems.transparent);
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
                _buildForgetPasswordBtn(gm),
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
                      contentPadding: EdgeInsets.all(MySizes.s_14),
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
                  onTap: () => _getVerifyCode(),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: MySizes.s_10,
                      vertical: MySizes.s_15,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(MySizes.s_24),
                        bottomRight: Radius.circular(MySizes.s_24),
                      ),
                    ),
                    child: Text(
                      gm.registerGetVerificationCodeTitle,
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
                contentPadding: EdgeInsets.all(MySizes.s_14),
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
                WhitelistingTextInputFormatter.digitsOnly,
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
                contentPadding: EdgeInsets.all(MySizes.s_14),
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

  Widget _buildForgetPasswordBtn(GmLocalizations gm) {
    return Padding(
      padding: EdgeInsets.only(top: MySizes.s_28),
      child: FlatButton(
        onPressed: () => _forgetPassword(),
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MySizes.s_24),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: MySizes.s_50,
        ),
        child: Text(
          gm.loginSubmitTitle,
          style: TextStyle(
            color: MyColors.c_ffa2b1,
            fontSize: MyFontSizes.s_14,
          ),
        ),
      ),
    );
  }

  _getVerifyCode() {
    if (_phoneGlobalKey.currentState.validate()) {
      var mobile = _phoneController.text;
      showLoading(context);
      LogUtils.d("mobile: $mobile");
    }
  }

  _forgetPassword() {
    if (_globalKey.currentState.validate()) {
      var mobile = _phoneController.text;
      var password = _passwordController.text;
      var code = _verifyCodeController.text;
      showLoading(context);
      LogUtils.d("mobile: $mobile , password: $password , code: $code");
      //Provider.of<UserProvider>(context, listen: true).user = null;
    }
  }
}
