import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_images.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/common/router/routers_navigate.dart';
import 'package:child_star/i10n/gm_localizations_intl.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final String text;
  final GestureTapCallback onTap;

  const SearchWidget({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(
          left: MySizes.s_4, right: MySizes.s_6, bottom: MySizes.s_8),
      child: GestureDetector(
        onTap: onTap ?? () => RoutersNavigate().navigateToHomeSearch(context),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints.expand(
                  width: double.infinity, height: MySizes.s_30),
              child: DecoratedBox(
                decoration: BoxDecoration(
                    color: MyColors.c_f7f7f7,
                    borderRadius: BorderRadius.circular(MySizes.s_14),
                    border: Border.all(color: MyColors.c_ececec)),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(
                    left: MySizes.s_8, top: MySizes.s_6, bottom: MySizes.s_6),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Image(
                    image: MyImages.ic_home_search,
                    width: MySizes.s_18,
                    height: MySizes.s_18,
                  ),
                )),
            Text(
              text ?? GmLocalizations.of(context).searchHintTitle,
              style: TextStyle(
                  color: MyColors.c_b6b6b6, fontSize: MyFontSizes.s_13),
            )
          ],
        ),
      ),
    );
  }
}
