import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/states/states_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ModifyNamePage extends StatefulWidget {
  static const TYPE_NICKNAME = 1;
  static const TYPE_SIGNATURE = 2;

  final int type;

  const ModifyNamePage(this.type, {Key key}) : super(key: key);

  @override
  _ModifyNamePageState createState() => _ModifyNamePageState(type);
}

class _ModifyNamePageState extends State<ModifyNamePage> {
  final int type;
  final GlobalKey<FormFieldState> _globalKey = GlobalKey();
  final TextEditingController _controller = TextEditingController();

  _ModifyNamePageState(this.type);
  @override
  Widget build(BuildContext context) {
    GmLocalizations gm = GmLocalizations.of(context);
    return Scaffold(
      appBar: MySystems.noAppBarPreferredSize,
      body: Container(
        color: MyColors.c_fafafa,
        child: Column(
          children: <Widget>[
            AppBarWidget(
              type == ModifyNamePage.TYPE_NICKNAME
                  ? gm.modifyNickNameTitle
                  : gm.modifySignatureTitle,
              isShowDivider: true,
              action: GestureDetector(
                onTap: () {
                  if (type == ModifyNamePage.TYPE_NICKNAME) {
                    _modifyNickName();
                  } else if (type == ModifyNamePage.TYPE_SIGNATURE) {
                    _modifySignature();
                  }
                },
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: MySizes.s_14),
                  child: Text(
                    gm.modifyNickNameSubmit,
                    style: TextStyle(
                      color: MyColors.c_686868,
                      fontSize: MyFontSizes.s_14,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: MySizes.s_16),
                child: Consumer<UserProvider>(
                  builder: (context, value, child) {
                    User user = value.user;
                    _controller.text = type == ModifyNamePage.TYPE_NICKNAME
                        ? user.nickName
                        : user.mySign;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: MySizes.s_20),
                        Text(
                          type == ModifyNamePage.TYPE_NICKNAME
                              ? gm.modifyNickNameTitle
                              : gm.modifySignatureTitle,
                          style: TextStyle(
                            color: MyColors.c_b6b6b6,
                            fontSize: MyFontSizes.s_11,
                          ),
                        ),
                        Stack(
                          alignment: Alignment.topRight,
                          children: <Widget>[
                            TextFormField(
                              key: _globalKey,
                              controller: _controller,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.done,
                              autofocus: true,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              style: TextStyle(
                                color: MyColors.c_777777,
                                fontSize: MyFontSizes.s_14,
                              ),
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.c_dfdfdf,
                                    width: MySizes.s_1,
                                  ),
                                ),
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: MyColors.c_dfdfdf,
                                    width: MySizes.s_1,
                                  ),
                                ),
                                contentPadding: EdgeInsets.all(MySizes.s_12),
                                isDense: true,
                              ),
                              maxLength: type == ModifyNamePage.TYPE_NICKNAME
                                  ? 16
                                  : 20,
                              validator: (value) {
                                if (type == ModifyNamePage.TYPE_NICKNAME) {
                                  if (!RegexUtils.checkNickName(value)) {
                                    return gm.modifyNickNameError;
                                  }
                                } else if (type ==
                                    ModifyNamePage.TYPE_SIGNATURE) {
                                  if (value == null || value.isEmpty) {
                                    return gm.modifySignatureError;
                                  }
                                }
                                return null;
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.clear,
                                color: Colors.grey,
                              ),
                              onPressed: () => _controller.clear(),
                            ),
                          ],
                        ),
                        type == ModifyNamePage.TYPE_NICKNAME
                            ? Text(
                                gm.modifyNickNameLimit,
                                style: TextStyle(
                                  color: MyColors.c_b6b6b6,
                                  fontSize: MyFontSizes.s_11,
                                ),
                              )
                            : SizedBox(),
                      ],
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _modifyNickName() {
    if (_globalKey.currentState.validate()) {
      _modifyUserInfo(nickName: _controller.text);
    }
  }

  _modifySignature() {
    if (_globalKey.currentState.validate()) {
      _modifyUserInfo(mySign: _controller.text);
    }
  }

  _modifyUserInfo({
    String nickName,
    String mySign,
  }) async {
    try {
      NetManager netManager = NetManager(context);
      await netManager.modifyUserInfo(
        nickName: nickName,
        mySign: mySign,
      );
      User user = await netManager.getUserInfo();
      Provider.of<UserProvider>(context).user = user;
      showToast(GmLocalizations.of(context).modifySuccessToast);
      Navigator.of(context).pop();
    } catch (e) {
      LogUtils.e(e);
    }
  }
}
