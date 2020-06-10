import 'dart:convert';

import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/routes/user/modify_name_page.dart';
import 'package:child_star/states/states_index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/page/user_widget.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ModifyUserInfoPage extends StatefulWidget {
  @override
  _ModifyUserInfoPageState createState() => _ModifyUserInfoPageState();
}

class _ModifyUserInfoPageState extends State<ModifyUserInfoPage> {
  Map<String, String> _provincesData;
  Map<String, dynamic> _citiesData;

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
              gm.modifyUserInfoTitle,
              isShowDivider: true,
            ),
            SizedBox(height: MySizes.s_20),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: MySizes.s_16),
                child: Consumer<UserProvider>(
                  builder: (context, value, child) {
                    User user = value.user;
                    return Column(
                      children: <Widget>[
                        //头像
                        GestureDetector(
                          onTap: () => _modifyAvatar(),
                          behavior: HitTestBehavior.opaque,
                          child: Stack(
                            alignment: Alignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.all(MySizes.s_6),
                                decoration: BoxDecoration(
                                  color: MyColors.c_f3f2f1,
                                  shape: BoxShape.circle,
                                ),
                                child: loadImage(
                                  user.headUrl,
                                  width: MySizes.s_86,
                                  height: MySizes.s_86,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Container(
                                width: MySizes.s_86,
                                height: MySizes.s_86,
                                margin: EdgeInsets.all(MySizes.s_6),
                                decoration: BoxDecoration(
                                  color: Colors.black38,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              Image(image: MyImages.ic_user_avatar_edit),
                            ],
                          ),
                        ),
                        SizedBox(height: MySizes.s_24),
                        Text(
                          gm.modifyUserInfoAvatar,
                          style: TextStyle(
                            color: MyColors.c_8c8c8c,
                            fontSize: MyFontSizes.s_10,
                          ),
                        ),
                        SizedBox(height: MySizes.s_22),
                        Divider(color: MyColors.c_dfdfdf, height: MySizes.s_1),
                        //昵称
                        buildText(
                          gm.modifyUserInfoNickName,
                          user.nickName,
                          () => _modifyNickName(),
                        ),
                        //性别
                        _buildSex(gm, user),
                        //地址
                        buildText(
                          gm.modifyUserInfoAddress,
                          "${user.province} ${user.city}",
                          () => _modifyAddress(),
                        ),
                        //个性签名
                        buildText(
                          gm.modifyUserInfoSignature,
                          user.mySign,
                          () => _modifySignature(),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildText(String title, String text, GestureTapCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.only(
          top: MySizes.s_16,
          bottom: MySizes.s_28,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: MyColors.c_8c8c8c,
                fontSize: MyFontSizes.s_15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  text,
                  style: TextStyle(
                    color: MyColors.c_b0b0b0,
                    fontSize: MyFontSizes.s_14,
                  ),
                ),
                SizedBox(width: MySizes.s_6),
                Image(image: MyImages.ic_mine_arrow),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSex(GmLocalizations gm, User user) {
    return Padding(
      padding: const EdgeInsets.only(
        top: MySizes.s_16,
        bottom: MySizes.s_28,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            gm.modifyUserInfoSex,
            style: TextStyle(
              color: MyColors.c_8c8c8c,
              fontSize: MyFontSizes.s_15,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              //女
              GestureDetector(
                onTap: () => _modifySex(user, 2),
                child: Container(
                  width: MySizes.s_45,
                  height: MySizes.s_23,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        user.sex == 2 ? MyColors.c_febfc9 : MyColors.c_d7d7d7,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(MySizes.s_12),
                      bottomLeft: Radius.circular(MySizes.s_12),
                    ),
                  ),
                  child: Image(image: MyImages.ic_user_female),
                ),
              ),
              //男
              GestureDetector(
                onTap: () => _modifySex(user, 1),
                child: Container(
                  width: MySizes.s_45,
                  height: MySizes.s_23,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color:
                        user.sex == 1 ? MyColors.c_bfd3fe : MyColors.c_d7d7d7,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(MySizes.s_12),
                      bottomRight: Radius.circular(MySizes.s_12),
                    ),
                  ),
                  child: Image(image: MyImages.ic_user_male),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  _modifyAvatar() {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return ModifyAvatarWidget(
          onCameraTap: () async {
            var image =
                await ImagePicker().getImage(source: ImageSource.camera);
            //设置状态栏颜色(白底黑字黑色图标)-选择完照片后状态栏字体变成白色了
            SystemChrome.setSystemUIOverlayStyle(MySystems.dark);
            if (image != null) {
              var result =
                  await NetManager(context).uploadFile(filePath: image.path);
              _modifyUserInfo(headUrl: result);
            }
          },
          onAlbumTap: () async {
            var image =
                await ImagePicker().getImage(source: ImageSource.gallery);
            //设置状态栏颜色(白底黑字黑色图标)-选择完照片后状态栏字体变成白色了
            SystemChrome.setSystemUIOverlayStyle(MySystems.dark);
            if (image != null) {
              var result =
                  await NetManager(context).uploadFile(filePath: image.path);
              _modifyUserInfo(headUrl: result);
            }
          },
        );
      },
    );
  }

  _modifyNickName() {
    RoutersNavigate()
        .navigateToModifyNamePage(context, ModifyNamePage.TYPE_NICKNAME);
  }

  ///sex：1男 2女
  _modifySex(User user, int sex) {
    if (user.sex != sex) {
      _modifyUserInfo(sex: sex.toString());
    }
  }

  _modifyAddress() async {
    if (_provincesData == null || _citiesData == null) {
      String provinceCityJson =
          await rootBundle.loadString(MyFiles.province_city);
      Map<String, dynamic> provinceCityMap = json.decode(provinceCityJson);
      if (provinceCityMap != null && provinceCityMap.isNotEmpty) {
        List provinceList = provinceCityMap["province"];
        if (provinceList != null && provinceList.isNotEmpty) {
          provinceList.asMap().forEach((provinceIndex, province) {
            String provinceName = province["name"];
            List cityList = province["city"];
            _provincesData ??= {};
            _provincesData.addAll({provinceIndex.toString(): provinceName});
            if (cityList != null && cityList.isNotEmpty) {
              Map<String, dynamic> cityValue = {};
              cityList.asMap().forEach((cityIndex, city) {
                String cityName = city["name"];
                cityValue.addAll({
                  ((cityIndex + 1) * 10000).toString(): {"name": cityName}
                });
              });
              _citiesData ??= {};
              _citiesData.addAll({provinceIndex.toString(): cityValue});
            }
          });
        }
      }
    }
    var result = await CityPickers.showCityPicker(
      context: context,
      showType: ShowType.pc,
      locationCode: "0",
      provincesData: _provincesData,
      citiesData: _citiesData,
    );
    if (result != null) {
      _modifyUserInfo(
          country: "中国", province: result.provinceName, city: result.cityName);
    }
  }

  _modifySignature() {
    RoutersNavigate()
        .navigateToModifyNamePage(context, ModifyNamePage.TYPE_SIGNATURE);
  }

  _modifyUserInfo({
    String headUrl,
    String nickName,
    String country,
    String province,
    String city,
    String sex,
    String mySign,
  }) async {
    try {
      NetManager netManager = NetManager(context);
      await netManager.modifyUserInfo(
        headUrl: headUrl,
        nickName: nickName,
        country: country,
        province: province,
        city: city,
        sex: sex,
        mySign: mySign,
      );
      User user = await netManager.getUserInfo();
      Provider.of<UserProvider>(context).user = user;
      showToast(GmLocalizations.of(context).modifySuccessToast);
    } catch (e) {
      LogUtils.e(e);
    }
  }
}
