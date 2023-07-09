import 'dart:convert';

import 'package:app_ro_client/data/socket_client/xt_socket_client.dart';
import 'package:app_ro_client/domain/models/transfer.dart';
import 'package:app_ro_client/presentation/dialogs/add_order_to_table_dialog_content.dart';
import 'package:flutter/material.dart';
import 'domain/models/order_item_request.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    XTSocketClient.connect().then((value) {
      XTSocketClient.on('changes_prods', (body) {
        print('changes prods : $body');
      });
    });
  }

  final List<OrderTable> _tables = [];

  final TextEditingController _tableNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            FloatingActionButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SizedBox(
                      width: 200,
                      height: 200,
                      child: Material(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: _tableNumberController,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                _tables.add(
                                  OrderTable(
                                    tableNumber:
                                        int.parse(_tableNumberController.text),
                                    orders: [],
                                  ),
                                );
                                setState(() {});
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              child: const Icon(Icons.table_bar),
            )
          ],
        ),
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemBuilder: (e, i) {
          final orders = _tables[i];
          return GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return AddOrderToTableDialogContent(
                    onSelect: (OrderItemRequest food) {
                      final exist = _tables[i]
                          .orders
                          .where((element) => element.name == food.name)
                          .isNotEmpty;
                      if (exist) {
                        final index = _tables[i]
                            .orders
                            .indexWhere((element) => element.name == food.name);
                        _tables[i].orders[index].increaseCount();
                      } else {
                        _tables[i].orders.add(food);
                      }
                      setState(() {});
                      notify();
                    },
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(24),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.greenAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...orders.orders.map(
                    (e) {
                      return Row(
                        children: [
                          Text('${e.name}    x${e.count}'),
                          const Padding(
                            padding: EdgeInsets.all(24),
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              e.decreaseCount();
                              setState(() {});
                              notify();
                            },
                            child: const Icon(Icons.remove),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(12),
                          ),
                          FloatingActionButton(
                              onPressed: () {
                                e.increaseCount();
                                setState(() {});
                                notify();
                              },
                              child: const Icon(Icons.add)),
                          const Padding(
                            padding: EdgeInsets.all(12),
                          ),
                          Text('${e.count * e.price}'),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
        itemCount: _tables.length,
      ),
      floatingActionButton: Column(
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              notify();
            },
            tooltip: 'Increment',
            child: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void notify() {
    XTSocketClient.send(
        "new_order", jsonEncode(TransferDTO(data: _tables).toJson()));
  }
}

extension Iterables<E> on List<E> {
  Map<K, List<E>> groupBy<K>(K Function(E) keyFunction) => fold(
      <K, List<E>>{},
      (Map<K, List<E>> map, E element) =>
          map..putIfAbsent(keyFunction(element), () => <E>[]).add(element));
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
