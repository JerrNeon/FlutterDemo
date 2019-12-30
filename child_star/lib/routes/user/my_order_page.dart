import 'package:child_star/common/resource_index.dart';
import 'package:child_star/i10n/i10n_index.dart';
import 'package:child_star/models/index.dart';
import 'package:child_star/utils/utils_index.dart';
import 'package:child_star/widgets/widget_index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyOrderPage extends StatefulWidget {
  @override
  _MyOrderPageState createState() => _MyOrderPageState();
}

class _MyOrderPageState extends State<MyOrderPage> {
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
              gm.mineOrder,
              isShowDivider: true,
            ),
            SizedBox(height: MySizes.s_6),
            Expanded(
              child: SmartRefresherWidget<MyOrder>.list(
                onRefreshLoading: (pageIndex) =>
                    NetManager(context).getMyOrderList(pageIndex: pageIndex),
                listItemBuilder: (context, index, data) {
                  return _buildItem(gm, data);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItem(GmLocalizations gm, MyOrder data) {
    int type = data.type; //订单类型 1：充值；2：购买vip；3：购买讲堂
    return Container(
      margin: EdgeInsets.only(
        left: MySizes.s_16,
        top: MySizes.s_8,
        right: MySizes.s_16,
      ),
      padding: EdgeInsets.only(
        top: MySizes.s_8,
        bottom: MySizes.s_10,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(MySizes.s_3),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(width: MySizes.s_10),
              Text(
                gm.myOrderNoTitle,
                style: TextStyle(
                  color: MyColors.c_8c8c8c,
                  fontSize: MyFontSizes.s_10,
                ),
              ),
              SizedBox(width: MySizes.s_5),
              VerticalDividerWidget(
                color: MyColors.c_c1c1c1,
                height: MySizes.s_10,
              ),
              SizedBox(width: MySizes.s_5),
              Text(
                data.orderNo,
                style: TextStyle(
                  color: MyColors.c_8c8c8c,
                  fontSize: MyFontSizes.s_10,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: MySizes.s_8,
              bottom: MySizes.s_14,
            ),
            child: Divider(
              color: MyColors.c_a6a6a6,
              height: MySizes.s_1,
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(width: MySizes.s_10),
              loadImage(
                data.goodsHeadUrl,
                width: MySizes.s_67,
                height: MySizes.s_45,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(MySizes.s_3),
              ),
              SizedBox(width: MySizes.s_10),
              Expanded(
                child: Text(
                  data.goodsTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: MyColors.c_8c8c8c,
                    fontSize: MyFontSizes.s_14,
                  ),
                ),
              ),
              SizedBox(width: MySizes.s_16),
            ],
          ),
          SizedBox(
            height: MySizes.s_10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              PaddingWidget(
                left: MySizes.s_10,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MySizes.s_5,
                    vertical: MySizes.s_2,
                  ),
                  decoration: BoxDecoration(
                    color: MyColorsFul.my_order_type[data.type],
                    borderRadius: BorderRadius.circular(MySizes.s_3),
                  ),
                  child: Text(
                    type == 1
                        ? gm.myOrderTypeRechargeTitle
                        : type == 2
                            ? gm.myOrderTypeVipTitle
                            : type == 3
                                ? gm.myOrderTypeCourseTitle
                                : gm.myOrderTypeBookTitle,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: MyFontSizes.s_10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              PaddingWidget(
                right: MySizes.s_16,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      "${gm.myOrderNumber1Title}${data.goodsNum}${gm.myOrderNumber2Title}",
                      style: TextStyle(
                        color: MyColors.c_8c8c8c,
                        fontSize: MyFontSizes.s_10,
                      ),
                    ),
                    SizedBox(width: MySizes.s_10),
                    Text(
                      "${gm.myOrderPriceTitle}",
                      style: TextStyle(
                        color: MyColors.c_fdabb9,
                        fontSize: MyFontSizes.s_10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    _buildPrice(gm, data),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MySizes.s_10),
        ],
      ),
    );
  }

  Widget _buildPrice(GmLocalizations gm, MyOrder data) {
    //支付方式 1：现金；2：知识点
    if (data.payType == 1) {
      return Text(
        "${gm.chinesePriceTitle} ${data.amount}",
        style: TextStyle(
          color: MyColors.c_fdabb9,
          fontSize: MyFontSizes.s_10,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image(
            image: MyImages.ic_mine_point,
            height: MySizes.s_10,
          ),
          Text(
            " ${data.amount}",
            style: TextStyle(
              color: MyColors.c_fdabb9,
              fontSize: MyFontSizes.s_10,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      );
    }
  }
}
