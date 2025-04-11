# moeda_verde

# CONFIGURANDO O FIREBASE NO APP

executar cli no terminal:

1º firebase login -> fazer login da sua conta no firebase

2º dart pub global activate flutterfire_cli -> instalar dependencias no projeto

3º flutterfire configure -> escolher o projeto do firebase que sera atrelado ao app

IDS GERADOS APOS O FLUTTERFIRE CONFIGURE:
Platform  Firebase App Id
web       1:652524923023:web:e56a43d34db7f11eece8fa
android   1:652524923023:android:4f7cbf9e8163d55dece8fa
ios       1:652524923023:ios:76988a5f5ee9a196ece8fa
macos     1:652524923023:ios:76988a5f5ee9a196ece8fa
windows   1:652524923023:web:8620b81474f1c0b7ece8fa

4º flutter pub add firebase_core -> instalar a dependencia para usarmos o arquivo firebase_options

5º flutterfire configure --project=moeda-verde-fausta-hom -> execute o comando para garantir que o Firebase esteja atualizado

6º add imports na main.dart:
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

7º add codigo na funcao main.dart:
WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
runApp(const MyApp());


# ATENCAO

caso o firebase_core esteja nas ultimas versoes o parametro ios do Podflie deve ser:
ios: 13.0

# PARA CONSEGUIR ACESSAR O FIRESTORE E EXECUTAR QUERIES

flutter pub add cloud_firestore -> vou baixar a dependencia que permite executar queries do firestore no flutter