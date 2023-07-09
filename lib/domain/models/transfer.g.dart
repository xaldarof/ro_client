// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transfer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransferDTO _$TransferDTOFromJson(Map<String, dynamic> json) => TransferDTO(
      data: (json['data'] as List<dynamic>)
          .map((e) => OrderTable.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransferDTOToJson(TransferDTO instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
