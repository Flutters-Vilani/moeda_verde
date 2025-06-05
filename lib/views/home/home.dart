import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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

  List cart = [];
  dynamic valueTotal = 0;
  dynamic saldo = 100.0;

  @override
  void initState() {
    products = jsonDecode(products);

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              valueTotal = 0;
              for (var i = 0; i < cart.length; i++) {
                valueTotal += cart[i]["price"];
              }
              showInDialog(
                context,
                title: Column(
                  children: [
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("FINALIZAR COMPRA"),
                      ],
                    ),
                  ],
                ),
                builder: (p0) {
                  return StatefulBuilder(
                    builder: (context, setStateDialog) {
                      return SizedBox(
                        height: 550,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: double.maxFinite,
                              height: 400,
                              child: ListView.builder(
                                shrinkWrap: true,
                                padding: const EdgeInsets.only(bottom: 20),
                                itemCount: cart.length,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Card(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(cart[index]['name']
                                                    .toString()),
                                                Text(
                                                    "R\$ ${cart[index]['price'].toString().replaceAll(".0", ",00")}"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              cart.removeAt(index);

                                              valueTotal = 0;
                                              for (var i = 0;
                                                  i < cart.length;
                                                  i++) {
                                                valueTotal += cart[i]["price"];
                                              }
                                            });
                                            setStateDialog(() {});

                                            if (cart.isEmpty) {
                                              finish(context);
                                            }
                                          },
                                          icon:
                                              Icon(Icons.remove_circle_outline))
                                    ],
                                  );
                                },
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "TOTAL: ",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "R\$ ${valueTotal.toString().replaceAll(".0", ",00")}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (saldo >= valueTotal) {
                                        setState(() {
                                          cart = [];

                                          saldo = saldo - valueTotal;
                                        });
                                        finish(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Compra realizada com sucesso!",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: Colors.green,
                                          ),
                                        );
                                        showInDialog(
                                          context,
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                "Código para retirada:",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          builder: (contextCod) {
                                            return Container(
                                              alignment: Alignment.center,
                                              height: 350,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    "EXP1234FAUSTA",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 26,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    "Você deve mostrar esse código na escola para retirar seus produtos!",
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      // fontSize: 26,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        finish(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                              "Você não possui saldo suficiente para finalizar a compra.",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            backgroundColor: Colors.red,
                                          ),
                                        );
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(12),
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "COMPRAR",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      finish(context);
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      padding: EdgeInsets.all(12),
                                      width: double.maxFinite,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        "FECHAR",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            icon: cart.isEmpty
                ? Container()
                : Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
          )
        ],
        backgroundColor: Colors.primaries[8],
        title: Text(
          "Moeda Verde",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
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
                        "R\$ ${saldo.toString().replaceAll(".0", ",00")}",
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
                            cart.add(products[index]);
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: GestureDetector(
                onTap: () {
                  print("teste");
                },
                child: Icon(Icons.settings)),
          ),
        ],
      ),
    );
  }
}
