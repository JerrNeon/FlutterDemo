import 'package:json_annotation/json_annotation.dart';

part 'myOrder.g.dart';

@JsonSerializable()
class MyOrder {
    MyOrder();

    String amount;
    String createdAt;
    String goodsHeadUrl;
    num goodsId;
    num goodsNum;
    String goodsTitle;
    num id;
    String orderNo;
    num payChannel;
    num payType;
    String payedAt;
    String paymentNo;
    String price;
    num status;
    String total;
    num type;
    num uid;
    String updatedAt;
    
    factory MyOrder.fromJson(Map<String,dynamic> json) => _$MyOrderFromJson(json);
    Map<String, dynamic> toJson() => _$MyOrderToJson(this);
}
