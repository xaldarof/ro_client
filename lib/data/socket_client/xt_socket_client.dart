import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:app_ro_client/data/socket_client/base_dto.dart';
import 'package:app_ro_client/domain/models/order_item_request.dart';

class XTSocketClient {
  static Socket? _socket;
  static final StreamController<BaseDTO> _streamController =
      StreamController();

  static void on(String event, Function(String body) callback) {
    _streamController.stream.listen((currEvent) {
      if (currEvent.event == event) {
        callback.call(currEvent.body);
      }
    });
  }

  static Future<void> connect() async {
    _socket = await Socket.connect('localhost', 5555);
    // connect to the socket server
    print('Connected to: ${_socket?.address.host}:${_socket?.remotePort}');
    _socket?.listen((Uint8List data) {
      final serverResponse = String.fromCharCodes(data);
      final decoded = BaseDTO.fromMap(jsonDecode(serverResponse));
      _streamController.add(decoded);
      print('Server: $serverResponse');
    }, onError: (error) {
      print(error);
      _socket?.destroy();
    }, onDone: () {
      print('Server left.');
      _socket?.destroy();
    });
  }

  static Future<void> send(String event, String message) async {
    _socket?.write(jsonEncode(BaseDTO(
            event: event,
            body: jsonEncode(
                const OrderItemRequest(name: "Osh", price: 23000).toMap()))
        .toMap()));
  }
}
