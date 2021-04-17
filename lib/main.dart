import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'models/data_models.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Firebase - Firestore'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Data> listUsuarios = [];

  @override
  void initState() {
    super.initState();
    obtenerUsuario();
  }

  void obtenerUsuario() async {
    CollectionReference crUsuario =
        FirebaseFirestore.instance.collection("usuario");

    QuerySnapshot usuarios = await crUsuario.get();

    if (usuarios.docs.length != 0) {
      for (var doc in usuarios.docs) {
        listUsuarios
            .add(Data(nombre: doc['nombre'], profesion: doc['profesion']));
        print(doc.data());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: listUsuarios.length,
          itemBuilder: (BuildContext context, i) {
            final k = listUsuarios[i];
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black, style: BorderStyle.solid)),
              child: Column(
                children: [
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                      child: Text("Nombre: " + k.nombre,
                          style: TextStyle(fontSize: 20))),
                  Container(
                      child: Text("Profesion: " + k.profesion,
                          style: TextStyle(fontSize: 20))),
                  SizedBox(
                    height: 15.0,
                  )
                ],
              ),
            );
          },
        ));
  }
}
