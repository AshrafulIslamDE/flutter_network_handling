// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response_converter.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) {
  return BaseResponse()
    ..data = json['data'] as Map<String, dynamic>?
    ..success = json['success'] as bool?
    ..message = json['message'] as String?
    ..responseCode = json['responseCode'] as int?;
}

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
      'success': instance.success,
      'message': instance.message,
      'responseCode': instance.responseCode,
    };

Pagination<T> _$PaginationFromJson<T>(Map<String, dynamic> json) {
  return Pagination<T>(
    (json['contentList'] as List<dynamic>?)
        ?.map(_Converter<T>().fromJson)
        .toList(),
  )
    ..totalPages = json['totalPages'] as int?
    ..numberOfResults = json['numberOfResults'] as int?
    ..nextPage = json['nextPage'] as int?;
}

Map<String, dynamic> _$PaginationToJson<T>(Pagination<T> instance) =>
    <String, dynamic>{
      'contentList': instance.contentList?.map(_Converter<T>().toJson).toList(),
      'totalPages': instance.totalPages,
      'numberOfResults': instance.numberOfResults,
      'nextPage': instance.nextPage,
    };
