import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<dynamic> _itmes = [];
  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('products');

  Future<void> readJson() async {
    // final input = File('wc.csv').openRead();
    //  final input = await rootBundle.loadString('assets/wc.csv');
    //  List<List<dynamic>> fields = const CsvToListConverter().convert(input);

//   setState(() {
//     _itmes = fields;
//   });
    final String response = await rootBundle.loadString('assets/wc.json');
    final data = await json.decode(response);
    setState(() {
      _itmes = data['items'];
    });
  }

  upLoadTofirestor() async{
    print('okkkk');
    for(int i=0;i<=_itmes.length;i++){
      await _firestore.add({
        "id": _itmes[i]['id'],
        "ref": _itmes[i]['ref'],
        "Name": _itmes[i]['Name'],
        "short_description": _itmes[i]['short_description'],
        "description": _itmes[i]['description'],
        "price": _itmes[i]['price'],
        "category": _itmes[i]['category'],
        "images": _itmes[i]['images'],
      }).catchError((value) => print(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _itmes.isNotEmpty
              ? ElevatedButton(
                  onPressed: () => upLoadTofirestor(),
                  child: const Text('upload'))
              : Container(),
          _itmes.isNotEmpty
              ? Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: _itmes.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ListTile(
                            leading: Text(index.toString()),
                            title: Text(_itmes[1].toString(),
                                style: Theme.of(context).textTheme.bodyLarge),
                            trailing: Text(_itmes[index][7].toString()),
                          ),
                        );
                      }),
                )
              : ElevatedButton(
                  onPressed: () => readJson(),
                  child: const Text('Carrega ficheiro.')),
        ],
      ),
    );
  }
}
