// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myOrder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyOrder _$MyOrderFromJson(Map<String, dynamic> json) {
  return MyOrder()
    ..amount = json['amount'] as String
    ..createdAt = json['createdAt'] as String
    ..goodsHeadUrl = json['goodsHeadUrl'] as String
    ..goodsId = json['goodsId'] as num
    ..goodsNum = json['goodsNum'] as num
    ..goodsTitle = json['goodsTitle'] as String
    ..id = json['id'] as num
    ..orderNo = json['orderNo'] as String
    ..payChannel = json['payChannel'] as num
    ..payType = json['payType'] as num
    ..payedAt = json['payedAt'] as String
    ..paymentNo = json['paymentNo'] as String
    ..price = json['price'] as String
    ..status = json['status'] as num
    ..total = json['total'] as String
    ..type = json['type'] as num
    ..uid = json['uid'] as num
    ..updatedAt = json['updatedAt'] as String;
}

Map<String, dynamic> _$MyOrderToJson(MyOrder instance) => <String, dynamic>{
      'amount': instance.amount,
      'createdAt': instance.createdAt,
      'goodsHeadUrl': instance.goodsHeadUrl,
      'goodsId': instance.goodsId,
      'goodsNum': instance.goodsNum,
      'goodsTitle': instance.goodsTitle,
      'id': instance.id,
      'orderNo': instance.orderNo,
      'payChannel': instance.payChannel,
      'payType': instance.payType,
      'payedAt': instance.payedAt,
      'paymentNo': instance.paymentNo,
      'price': instance.price,
      'status': instance.status,
      'total': instance.total,
      'type': instance.type,
      'uid': instance.uid,
      'updatedAt': instance.updatedAt
    };
