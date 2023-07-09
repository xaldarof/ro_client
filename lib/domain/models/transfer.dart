import 'package:app_ro_client/domain/models/order_item_request.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transfer.g.dart';

@JsonSerializable()
class TransferDTO {
  List<OrderTable> data;

  TransferDTO({
    required this.data,
  });

  Map<String, dynamic> toJson() => _$TransferDTOToJson(this);

  factory TransferDTO.fromMap(Map<String, dynamic> map) {
    return TransferDTO(
      data: map['data'] as List<OrderTable>,
    );
  }
}
