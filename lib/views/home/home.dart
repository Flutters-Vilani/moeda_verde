import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
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
                  return SizedBox(
                    height: 450,
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.maxFinite,
                          height: 350,
                          child: ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.only(bottom: 20),
                            itemCount: 2,
                            itemBuilder: (context, index) {
                              return Text("Teste");
                            },
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            print(cart.toString());
                            setState(() {
                              cart = [];
                            });
                            finish(context);
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
                        "100,00",
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
            itemCount: 2,
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
                        children: [
                          Text("Alface"),
                          Text("R\$ 10,00"),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            cart.add(index);
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
            icon: Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
