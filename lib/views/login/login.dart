import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moeda_verde/views/home/home.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController nome = TextEditingController();
  TextEditingController senha = TextEditingController();

  Future<bool> autentica(String nome, String senha) async {
    try {
      FirebaseFirestore db = FirebaseFirestore.instance;

      QuerySnapshot query = await db
          .collection("usuarios")
          .where("nome", isEqualTo: nome)
          .where("senha", isEqualTo: senha)
          .get();

      if (query.docs.isNotEmpty) {
        // Usuário encontrado
        print("Usuário autenticado: ${query.docs.first.data()}");

        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Home()));
        return true;
      } else {
        // Nenhum usuário com esse nome e senha
        print("Usuário não encontrado");

        return false;
      }
    } catch (e) {
      print("Erro ao autenticar: $e");
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: nome,
            decoration: InputDecoration(hintText: 'Nome'),
          ),
          TextField(
            controller: senha,
            decoration: InputDecoration(hintText: 'Senha'),
          ),
          GestureDetector(
            onTap: () {
              autentica(nome.text, senha.text);
            },
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 20),
              width: double.maxFinite,
              height: 50,
              decoration: BoxDecoration(color: Colors.blue),
              child: Text("Entrar"),
            ),
          )
        ],
      ),
    );
  }
}
