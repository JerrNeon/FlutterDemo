import 'package:child_star/common/my_colors.dart';
import 'package:child_star/common/my_images.dart';
import 'package:child_star/common/my_sizes.dart';
import 'package:child_star/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class HomeNewPage extends StatefulWidget {
  @override
  _HomeNewPageState createState() => _HomeNewPageState();
}

class _HomeNewPageState extends State<HomeNewPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: <Widget>[
          SearchWidget(),
          Container(
            color: MyColors.c_f0f0f0,
            child: Column(
              children: <Widget>[
                _buildTag(),
                _buildBanner(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTag() {
    final _list = ["胎儿发育", "女人私房话", "哺乳期饮食"];
    return Padding(
      padding: EdgeInsets.only(
          top: MySizes.s_6, bottom: MySizes.s_6, right: MySizes.s_6),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(MySizes.s_20),
            bottomRight: Radius.circular(MySizes.s_20),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MySizes.s_10, vertical: MySizes.s_8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Image(
                image: MyImages.icon_home_tag,
                width: MySizes.s_25,
                height: MySizes.s_20,
              ),
              Expanded(
                child: Container(
                  height: MySizes.s_20,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(
                      left: MySizes.s_6,
                      right: MySizes.s_6,
                    ),
                    itemBuilder: (context, index) {
                      return _buildTagItem(_list[index]);
                    },
                    itemCount: 3,
                  ),
                ),
              ),
              GestureDetector(
                child: Image(
                  image: MyImages.icon_home_tagall,
                  width: MySizes.s_30,
                  height: MySizes.s_30,
                ),
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTagItem(String text) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: MySizes.s_4),
        padding: EdgeInsets.symmetric(
            horizontal: MySizes.s_8, vertical: MySizes.s_2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(MySizes.s_10),
            border: Border.all(
              color: MyColors.c_c0c0c0,
              width: MySizes.s_1,
            )),
        child: Text(
          text,
          style: TextStyle(color: MyColors.c_a7a7a7, fontSize: MySizes.s_12),
        ),
      ),
    );
  }

  Widget _buildBanner() {
    final _list = [
      "https://mplanetasset.allyes.com/images/1572248293173n3650_732x306.jpg",
      "https://mplanetasset.allyes.com/images/1572248460296n7845_732x306.jpg",
      "https://mplanetasset.allyes.com/images/1572248581709n4876_732x306.jpg"
    ];
    return Padding(
      padding: EdgeInsets.only(
        left: MySizes.s_4,
        right: MySizes.s_4,
      ),
      child: AspectRatio(
        aspectRatio: 366.0 / 153.0,
        child: Swiper(
          itemCount: _list.length,
          autoplay: true,
          autoplayDelay: 5000,
          pagination: SwiperPagination(
              margin: EdgeInsets.only(bottom: MySizes.s_6),
              builder: DotSwiperPaginationBuilder(
                activeColor: MyColors.c_ffa2b1,
                color: Colors.white,
                activeSize: MySizes.s_6,
                size: MySizes.s_6,
              )),
          controller: SwiperController(),
          itemBuilder: (context, index) {
            return Image.network(
              _list[index],
              fit: BoxFit.fill,
            );
          },
        ),
      ),
    );
  }
}
