import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:moeda_verde/views/home/home.dart';
import 'package:moeda_verde/views/utils/input.dart';

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
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (ctx) => Home()));
        return true;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Usuário não encontrado. O nome ou senha estão errados!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.red,
          ),
        );

        return false;
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Não foi possível fazer a autenticação. Verifique sua internet!",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.red,
        ),
      );
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(6),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Input(
              controller: nome,
              hintText: 'Nome',
              obscure: false,
            ),
            SizedBox(
              height: 10,
            ),
            Input(
              controller: senha,
              hintText: 'Senha',
              obscure: true,
              tipoInput: "password",
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
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  "Entrar",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
