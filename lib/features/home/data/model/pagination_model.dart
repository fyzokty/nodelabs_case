import 'dart:convert';

import '../../domain/entity/pagination.dart';

class PaginationModel extends Pagination {
  PaginationModel({
    required super.totalCount,
    required super.perPage,
    required super.maxPage,
    required super.currentPage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalCount': totalCount,
      'perPage': perPage,
      'maxPage': maxPage,
      'currentPage': currentPage,
    };
  }

  factory PaginationModel.fromMap(Map<String, dynamic> map) {
    return PaginationModel(
      totalCount: (map["totalCount"] ?? 0) as int,
      perPage: (map["perPage"] ?? 0) as int,
      maxPage: (map["maxPage"] ?? 0) as int,
      currentPage: (map["currentPage"] ?? 0) as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaginationModel.fromJson(String source) =>
      PaginationModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
