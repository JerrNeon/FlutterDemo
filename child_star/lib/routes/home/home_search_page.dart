import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_images.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/common/my_systems.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:flutter/material.dart';

class HomeSearchPage extends StatefulWidget {
  @override
  _HomeSearchPageState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final gm = GmLocalizations.of(context);
    return Scaffold(
        appBar: MySystems.noAppBarPreferredSize,
        body: Padding(
          padding: EdgeInsets.only(
              right: MySizes.s_10, top: MySizes.s_8, bottom: MySizes.s_8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(padding: EdgeInsets.all(MySizes.s_4)),
                  Expanded(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                          color: MyColors.c_f7f7f7,
                          borderRadius: BorderRadius.circular(MySizes.s_14),
                          border: Border.all(
                            color: MyColors.c_ececec,
                            width: MySizes.s_1,
                          )),
                      child: TextField(
                        controller: _textEditingController,
                        maxLines: 1,
                        style: TextStyle(
                          color: MyColors.c_797979,
                          fontSize: MyFontSizes.s_13,
                        ),
                        decoration: InputDecoration(
                          icon: Padding(
                            padding: EdgeInsets.only(left: MySizes.s_8),
                            child: Image(
                              image: MyImages.ic_home_search,
                              width: MySizes.s_18,
                              height: MySizes.s_18,
                            ),
                          ),
                          hintText: gm.searchHintTitle,
                          hintStyle: TextStyle(
                              color: MyColors.c_b6b6b6,
                              fontSize: MyFontSizes.s_13),
                          contentPadding: EdgeInsets.only(
                              right: MySizes.s_12,
                              top: MySizes.s_6,
                              bottom: MySizes.s_6),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
