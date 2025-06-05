import 'dart:convert';

import 'package:flutter/material.dart';

class BodyHome extends StatefulWidget {
  List cart;
  dynamic valueTotal;
  dynamic saldo;
  // final List cart;
  BodyHome(
      {required this.cart,
      required this.valueTotal,
      required this.saldo,
      super.key});

  @override
  State<BodyHome> createState() => _BodyHomeState();
}

class _BodyHomeState extends State<BodyHome> {
  dynamic products = """
[
  {
    "id": 1,
    "name": "Alface",
    "price": 10.00,
    "image": "https://example.com/alface.png"
  },
  {
    "id": 2,
    "name": "Tomate",
    "price": 5.00,
    "image": "https://example.com/tomate.png"
  }
]
""";

  @override
  void initState() {
    products = jsonDecode(products);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: double.maxFinite,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Minha Carteira",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "R\$ ${widget.saldo.toString().replaceAll(".0", ",00")}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        ListView.builder(
          itemCount: products.length,
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // imagem
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(products[index]['name']),
                        Text(
                          "R\$ ${products[index]['price'].toStringAsFixed(2)}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          widget.cart.add(products[index]);
                        });
                      },
                      icon: Icon(Icons.add_outlined),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
