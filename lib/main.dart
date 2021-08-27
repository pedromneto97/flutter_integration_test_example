import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(MyApp());
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? pokemonName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'INTEGRATION TEST',
        ),
      ),
      body: Column(
        mainAxisAlignment: pokemonName == null
            ? MainAxisAlignment.center
            : MainAxisAlignment.spaceAround,
        children: [
          if (pokemonName != null) Text(pokemonName!),
          Center(
            child: ElevatedButton(
              onPressed: onPress,
              child: Text(
                'REQUEST',
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onPress() async {
    const url = String.fromEnvironment('BASE_URL') + '/pokemon/1';
    final body = await Client()
        .get(
          Uri.parse(url),
        )
        .then(
          (value) => jsonDecode(value.body),
        );
    setState(() {
      pokemonName = body['name'];
    });
  }
}
