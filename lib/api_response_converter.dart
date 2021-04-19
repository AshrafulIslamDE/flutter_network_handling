
import 'package:json_annotation/json_annotation.dart';

part 'api_response_converter.g.dart';

@JsonSerializable()
class BaseResponse {
  BaseResponse();
  BaseResponse.instance(this.data);
  @JsonKey(name:'data' )
  Map<String,dynamic>? data;
  @JsonKey(name:'success' )
  bool? success;
  @JsonKey(name:'message' )
  String? message;
  @JsonKey(name:'responseCode' )
  int? responseCode;

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}

@JsonSerializable()
class Pagination<T> {
  Pagination(this.contentList);

  Pagination.instance(
      this.contentList, this.totalPages, this.numberOfResults, this.nextPage);

  @_Converter()
  @JsonKey(name:'contentList' )
  List<T>? contentList;
  @JsonKey(name:'totalPages' )
  int? totalPages=0;
  @JsonKey(name:'numberOfResults' )
  int? numberOfResults=0;
  @JsonKey(name:'nextPage' )
  int? nextPage=0;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson<T>(json);

  Map<String, dynamic> toJson() => _$PaginationToJson(this);
}


class _Converter<T> implements JsonConverter<T, Object?> {
  const _Converter();

  @override
  T fromJson(Object? json) {
    return json as T;
  }

  @override
  Object? toJson(T object) {
    return object;
  }
}
convertGenericListToDefinedList<T>(List<dynamic>? items) {
  return items?.map(_Converter<T>().fromJson).toList();
}

