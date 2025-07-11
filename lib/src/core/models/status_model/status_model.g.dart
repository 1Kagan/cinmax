// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatusModel _$StatusModelFromJson(Map<String, dynamic> json) => StatusModel(
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      errorCode: (json['error_code'] as num?)?.toInt(),
      errorMessage: json['error_message'] as String?,
      elapsed: (json['elapsed'] as num?)?.toInt(),
      creditCount: (json['credit_count'] as num?)?.toInt(),
    );
