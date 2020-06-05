import 'package:json_annotation/json_annotation.dart';
import "myCollection.dart";
part 'myCollectionPageList.g.dart';

@JsonSerializable()
class MyCollectionPageList {
    MyCollectionPageList();

    num pageNum;
    num pageSize;
    num totalNum;
    String ids;
    List<MyCollection> resultList;
    
    factory MyCollectionPageList.fromJson(Map<String,dynamic> json) => _$MyCollectionPageListFromJson(json);
    Map<String, dynamic> toJson() => _$MyCollectionPageListToJson(this);
}
