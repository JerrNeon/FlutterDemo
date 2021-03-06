import 'package:json_annotation/json_annotation.dart';

import "user.dart";

part 'repo.g.dart';

@JsonSerializable()
class Repo {
  Repo();

  num id;
  String name; //项目名称
  // ignore: non_constant_identifier_names
  String full_name; //项目完成名称
  User owner; // 项目拥有者，结构见"user.json"
  Repo parent; // 如果是fork的项目，则此字段表示fork的父项目信息
  bool private; // 是否私有项目
  String description; //项目描述
  bool fork; // 该项目是否为fork的项目
  String language; //该项目的主要编程语言
  // ignore: non_constant_identifier_names
  num forks_count; // fork了该项目的数量
  // ignore: non_constant_identifier_names
  num stargazers_count; //该项目的star数量
  num size; // 项目占用的存储大小
  // ignore: non_constant_identifier_names
  String default_branch; //项目的默认分支
  // ignore: non_constant_identifier_names
  num open_issues_count; //该项目当前打开的issue数量
  // ignore: non_constant_identifier_names
  String pushed_at;
  // ignore: non_constant_identifier_names
  String created_at;
  // ignore: non_constant_identifier_names
  String updated_at;
  // ignore: non_constant_identifier_names
  num subscribers_count; //订阅（关注）该项目的人数
  Map<String, dynamic> license; // 该项目的开源许可证

  factory Repo.fromJson(Map<String, dynamic> json) => _$RepoFromJson(json);
  Map<String, dynamic> toJson() => _$RepoToJson(this);
}
